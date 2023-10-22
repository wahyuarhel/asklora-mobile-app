package local;

import com.google.common.collect.ImmutableMap;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileBy;
import io.appium.java_client.MobileElement;
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

public class LocalBotstockTest {
    String directory = String.valueOf(new File(System.getProperty("user.dir")).getParent());
    Dotenv dotenv = Dotenv.configure().directory(directory).ignoreIfMalformed().filename(".env").load();
    AppiumDriver driver;
    WebDriverWait wait;
    final SlackOTP slackToken = new SlackOTP();

    String platformVersion;
    String udid;
    String deviceName;
    String platformValue;
    String otp;
    ArrayList<String> deviceProperties = new ArrayList<>();

    final String FIND_BY_EDIT_TEXT = "android.widget.EditText";
    final String FIND_BY_BUTTON = "android.widget.Button";
    final String PORTFOLIO_VIEW = "//android.widget.ImageView[contains(@content-desc, 'Total Portfolio Value')]";
    final String email = "testemail213982@yopmail.com" ;
    final String password = "Password1234!";
    final String TEST_APP = "Stag";

    String[] omnisearch = { "auto stocks", "bank stocks", "tesla", "car", "tech", "medical", "research", "oil", "burger", "robot" };
    String[] investDuration = {"1 year", "Half a year", "3 Months", "1 Month", "2 Weeks"};
    String[] largeAmount = { "Strongly disagree", "Disagree", "Neutral", "Agree", "Strongly Agree" };
    String[] investmentScenario = { "Limited loss", "Passive income", "Lora please choose for me", "Just buy my stock" };

    @BeforeTest
    public void setUp() throws IOException {
        getPropValues();

        System.out.println("Platform Version: " + platformVersion);
        System.out.println("udid: " + udid);
        System.out.println("Device Name: " + deviceName);

        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("build", "Asklora_Stag_10218");
        caps.setCapability("name","Buy Botstock Test");
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
        Assert.assertTrue(driver.findElement(By.xpath(PORTFOLIO_VIEW)).isDisplayed(), "Portfolio view is not displayed");
    }

    @Test(priority = 3)
    public void testStartBotstock() {
        implicitWait(5);
        clickElementByXpath("//android.widget.Button[@content-desc='Start A Botstock']");
        try {
            Assert.assertTrue(driver.findElement(By.xpath("//android.view.View[contains(@content-desc, 'investing mojo')]"))
                    .isDisplayed(), "Omnisearch view is not displayed");
        } catch (Exception e) {
            goToRightView();
        }
    }

    public void goToRightView() {
        clickContentDescription("Change Investment Style");
    }

    @Test(priority = 4)
    public void testKeywords() {
        int resetInt = randomize(0, 1);
        if (resetInt == 0) {
            System.out.println("Not resetting omnisearch");
            clickContentDescription("Next");
            clickContentDescription("View Botstock Recommendation");
        } else {
            System.out.println("Resetting omnisearch");
            clickContentDescription("Reset");
            randomizeKeyword();
            clickContentDescription("Next");
            clickElementsByClass(FIND_BY_BUTTON, 0);
            clickContentDescription(investDuration[randomize(0, 4)]);
            clickElementsByClass(FIND_BY_BUTTON, 1);
            clickContentDescription(largeAmount[randomize(0, 4)]);
            clickElementsByClass(FIND_BY_BUTTON, 2);
            clickContentDescription(investmentScenario[randomize(0, 4)]);
            clickContentDescription("View Botstock Recommendation");
        }
        Assert.assertTrue(driver.findElement(By.xpath("//android.view.View[contains(@content-desc, 'investing mojo')]"))
                .isDisplayed(), "Recommended Botstock view is not displayed");
    }

    @Test(priority = 5)
    public void testTrade() {
        clickElementsByXpath("//android.widget.Button[@content-desc='Trade']", randomize(0, 5));
        clickContentDescription("Trade");
        clickElementByClass(FIND_BY_EDIT_TEXT);
        driver.findElement(By.className(FIND_BY_EDIT_TEXT)).sendKeys(String.valueOf(randomize(15000, 20000)));
        clickContentDescription("Next");
        clickContentDescription("Confirm");
        clickContentDescription("BACK TO HOME");
        Assert.assertTrue(driver.findElement(By.xpath("//android.widget.ImageView[@content-desc='Tab 1 of 4']"))
                .isSelected(), "Omnisearch view is not displayed");
    }

    @AfterTest
    public void tearDown() {
        if (driver != null)
            driver.quit();
    }

    public void clickElementByXpath(String element) {
        driver.findElement(By.xpath(element)).click();
    }

    public void clickElementByClass(String element) {
        driver.findElement(By.className(element)).click();
    }


    public void clickContentDescription(String element) {
        driver.findElement(new MobileBy.ByAndroidUIAutomator(
                        "new UiScrollable(new UiSelector().scrollable(true))" +
                                ".scrollIntoView(new UiSelector().descriptionContains(\"" + element + "\"))"))
                .click();
    }

    public void clickClassName(String element) {
        driver.findElement(new MobileBy.ByAndroidUIAutomator(
                        "new UiScrollable(new UiSelector().scrollable(true))" +
                                ".scrollIntoView(new UiSelector().className(\"" + element + "\"))"))
                .click();
    }

    public void clickElementsByClass(String element, int num) {
        MobileElement classElement = (MobileElement) driver.findElements(By.className(element)).get(num);
        classElement.click();
    }

    public void clickElementsByXpath(String element, int num) {
        MobileElement xpathElement = (MobileElement) driver.findElements(By.xpath(element)).get(num);
        xpathElement.click();
    }

    public void getPropValues() throws IOException {
        Properties prop = new Properties();
        FileInputStream ip = new FileInputStream("config.properties");
        prop.load(ip);
        prop.forEach((k, v) -> deviceProperties.add((String) v));
        System.out.println(deviceProperties);

        platformVersion = deviceProperties.get(0);
        udid = deviceProperties.get(1);
        deviceName = deviceProperties.get(2);
    }

    public void getOTP() {
        if (TEST_APP.equals("Dev")) {
            otp = slackToken.fetchHistory(email);
        } else {
            Scanner scanner = new Scanner(System.in);
            System.out.print("Enter otp: ");
            otp = scanner.nextLine();
            System.out.println("Received otp: " + otp);
        }

        int[] otpInts = new int[otp.length()];
        for (int i = 0; i < otp.length(); i++) {
            otpInts[i] = Integer.parseInt(String.valueOf(otp.charAt(i)));
        }
        System.out.println(Arrays.toString(otpInts));
        for (int i = 0; i < otp.length(); i++) {
            ((AndroidDriver) driver).pressKey(new KeyEvent(typeNum(otpInts[i])));
        }

        driver.findElement(By.xpath("//android.view.View[2]")).sendKeys(otp);
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

    public void randomizeKeyword() {
        List<String> strList = Arrays.asList(omnisearch);
        Collections.shuffle(strList);
        strList.toArray(omnisearch);
        int randNum = randomize(2, omnisearch.length-1);
        for (int i = 0; i < randNum; i++) {
            driver.findElement(By.className(FIND_BY_EDIT_TEXT)).sendKeys(omnisearch[i]);
            clickElementByClass("android.widget.Button");
            clickClassName(FIND_BY_EDIT_TEXT);
        }
    }

    public void implicitWait(int period) {
        driver.manage().timeouts().implicitlyWait(period < 1 ? 3 : period, TimeUnit.SECONDS);
    }

    public int randomize(int min, int max) {
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }

}
