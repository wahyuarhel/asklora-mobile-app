package local;

import com.google.common.collect.ImmutableMap;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileBy;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.android.nativekey.AndroidKey;
import io.appium.java_client.android.nativekey.KeyEvent;
import io.github.cdimascio.dotenv.Dotenv;
import org.openqa.selenium.By;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;
import utils.SlackOTP;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;

public class LocalWithdrawTest {
    String directory = String.valueOf(new File(System.getProperty("user.dir")).getParent());
    Dotenv dotenv = Dotenv.configure().directory(directory).ignoreIfMalformed().filename(".env").load();

    AppiumDriver driver;
    WebDriverWait wait;
    final SlackOTP slackToken = new SlackOTP();

    String platformVersion;
    String udid;
    String deviceName;
    String platformValue;
    String withdrawVal;
    String otp;
    Map<String, String> deviceProperties = new HashMap<>();

    final String PORTFOLIO_VIEW = "//android.widget.ImageView[contains(@content-desc, 'Total Portfolio Value')]";
    final String email = "testemail213982@yopmail.com";
    final String password = "Password1234!";
    final String TEST_APP = "Stag";

    @BeforeTest
    public void setUp() throws IOException {
        getPropValues();

        System.out.println("Platform Version: " + platformVersion);
        System.out.println("udid: " + udid);
        System.out.println("Device Name: " + deviceName);

        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("build", "Asklora_Stag_10218");
        caps.setCapability("name","Android Withdraw Test");
        caps.setCapability("deviceName", deviceName);
        caps.setCapability("platformVersion", platformVersion);
        caps.setCapability("udid", udid);
        caps.setCapability("automationName", "UiAutomator2");
        caps.setCapability("app", System.getProperty("user.dir") + "/apps/asklora_stag.apk");
        caps.setCapability("unicodeKeyboard", true);
        caps.setCapability("resetKeyboard", true);
//                 caps.setCapability("ignoreHiddenApiPolicyError", true);
        caps.setCapability("autoGrantPermissions", true);
//                 caps.setCapability("appPackage", "ai.asklora.app.stag");
//                 caps.setCapability("appActivity", ".MainActivity");
//                 caps.setCapability("noReset", true);
//                 caps.setCapability("autoLaunch", false);
        caps.setCapability("chromeOptions", ImmutableMap.of("w3c", false));
        caps.setCapability("newCommandTimeout", 0);

        driver = new AndroidDriver(new URL("http://localhost:4723/wd/hub"), caps);
        wait = new WebDriverWait(driver, 60);
    }


    @Test(priority = 1)
    public void testLogin() {
        clickContentDescription("Have An Account");
        clickElementByXpath("//android.widget.EditText[1]");
        driver.findElement(By.xpath("//android.widget.EditText[1]")).sendKeys(email);
        clickElementByXpath("//android.widget.EditText[2]");
        driver.findElement(By.xpath("//android.widget.EditText[2]")).sendKeys(password);
        clickElementByXpath("//android.widget.Button[@content-desc='Sign In']");
        getOTP();
    }

    @Test(priority = 2)
    public void testView() {
        clickElementByXpath("//android.widget.ImageView[3]");
        Assert.assertTrue(driver.findElement(By.xpath(PORTFOLIO_VIEW)).isDisplayed(), "Portfolio View is not displayed");
    }

    @Test(priority = 3)
    public void testWithdrawView() {
        implicitWait(5);
        clickElementByXpath("//android.widget.ImageView[@content-desc='Withdraw']");
        clickElementByXpath("//android.widget.Button[@content-desc='Withdraw']");
        Assert.assertTrue(driver.findElement(By.xpath("//android.view.View[contains(@content-desc, 'Withdrawable Amount')]"))
                .isDisplayed(), "Withdraw money view is displayed");
    }

    @Test(priority = 4)
    public void testWithdrawValue() {
        withdrawVal = String.valueOf(randomize(100, 10000));
        int[] withdrawInts = new int[withdrawVal.length()];
        for (int i = 0; i < withdrawVal.length(); i++) {
            withdrawInts[i] = withdrawVal.charAt(i) - '0';
        }
        System.out.println(Arrays.toString(withdrawInts));
        for (int i = 0; i < withdrawVal.length(); i++) {
            driver.findElement(By.xpath("//android.view.View[@content-desc='" + withdrawInts[i] + "']")).click();
        }
        double expectedTotal = Double.parseDouble(withdrawVal) / 10 - 10;
        clickContentDescription("Next");
        Assert.assertTrue(driver.findElement(By.xpath("//android.view.View[contains(@content-desc, '" + expectedTotal + "')]"))
                .isDisplayed(), "Actual total amount does not match expected total amount.");
    }

    @Test(priority = 5)
    public void testConfirmWithdraw() {
        clickContentDescription("Confirm");
        clickContentDescription("Done");
        Assert.assertTrue(driver.findElement(By.xpath("//android.view.View[contains(@content-desc, 'investing mojo')]"))
                .isDisplayed(), "Omnisearch view is not displayed");
    }

    @AfterTest
    public void tearDown() {
        if (driver != null)
            driver.quit();
    }


    public void getPropValues() throws IOException {
        Properties prop = new Properties();
        FileInputStream ip = new FileInputStream("config.properties");
        prop.load(ip);
        prop.forEach((k, v) -> deviceProperties.put((String) k, (String) v));
        System.out.println(deviceProperties);

        platformVersion = deviceProperties.get("platformVersion");
        udid = deviceProperties.get("udid");
        deviceName = deviceProperties.get("deviceName");
    }

    public void getOTP() {
        if (TEST_APP.equals("Dev")) {
            otp = slackToken.fetchHistory(email);
        } else {
            Scanner scanner = new Scanner(System.in);
            System.out.println("----- Enter otp -----");

            otp = scanner.nextLine();
            System.out.println("Received otp: " + otp);
        }

        // Press buttons according to to the otp
        int[] otpInts = new int[otp.length()];
        for (int i = 0; i < otp.length(); i++) {
            otpInts[i] = Integer.parseInt(String.valueOf(otp.charAt(i)));
        }
//        System.out.println(Arrays.toString(otpInts));
        for (int i = 0; i < otp.length(); i++) {
            ((AndroidDriver) driver).pressKey(new KeyEvent(typeNum(otpInts[i])));
        }

    }

    public AndroidKey typeNum(int digit) {
        switch (digit) {
            case 0: return AndroidKey.DIGIT_0;
            case 1: return AndroidKey.DIGIT_1;
            case 2: return AndroidKey.DIGIT_2;
            case 3: return AndroidKey.DIGIT_3;
            case 4: return AndroidKey.DIGIT_4;
            case 5: return AndroidKey.DIGIT_5;
            case 6: return AndroidKey.DIGIT_6;
            case 7: return AndroidKey.DIGIT_7;
            case 8: return AndroidKey.DIGIT_8;
            case 9: return AndroidKey.DIGIT_9;
        }
        return null;
    }

    public void clickElementByXpath(String element) {
        driver.findElement(By.xpath(element)).click();
    }

    public void clickContentDescription(String element) {
        driver.findElement(new MobileBy.ByAndroidUIAutomator(
                        "new UiScrollable(new UiSelector().scrollable(true))" +
                                ".scrollIntoView(new UiSelector().descriptionContains(\"" + element + "\"))"))
                .click();
    }

    public void implicitWait(int period) {
        driver.manage().timeouts().implicitlyWait(period < 1 ? 3 : period, TimeUnit.SECONDS);
    }

    public int randomize(int min, int max) {
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }


}
