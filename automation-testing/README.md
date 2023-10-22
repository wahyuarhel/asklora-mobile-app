# automation-testing

##### Table of Contents
[Local Automation Testing](#instructions-for-automation-testing-with-local-device)  
[LambdaTest Automation Testing](#instructions-for-automation-testing-on-lambdatest)  
[IMPORTANT](#important)

### Instructions for Automation Testing with Local Device
1) Install [Node.js](https://nodejs.org/en)
2) Follow this [link](https://www.browserstack.com/guide/download-and-install-appium) to install Appium and its dependencies  
##### You can use cli or gui to run the server
   3) The gui is no longer maintained. If you are using gui, go [here](https://github.com/appium/appium-desktop/releases/tag/v1.22.3-4) and download the corresponding file
   Once Appium Desktop is installed, go to advanced → put "localhost" for server address and check "Allow CORS"   
      - If you are using cli, first type `appium driver install uiautomator2` into cmd or terminal
      - Then type `appium --address=localhost --allow-cors --base-path /wd/hub` into cmd or terminal to start a server  

4) run "getProps.sh" before running the UI automation, the setUp method requires the device's name, udid, and version to perform automation

5) Create a folder called "apps" in the same directory as src then put the apk file into the folder and rename the apk to **"asklora_stag.apk"**. You can name the apk to something else but make sure to match the name of the apk in the setUp method in the following line.  
``` java
caps.setCapability("app", System.getProperty("user.dir") + "/apps/asklora_stag.apk");
```

6) Make sure JAVA_HOME and ANDROID_HOME are set up to use this program for automation  
To be able to interact with the scanner and using IntelliJ, go to:
Help → Edit Custom VM Options  
Add "-Deditable.java.test.console=true" and restart IDE  
You should be able to input the otp after restarting IDE
> **Note** I did not test automation using vs code, so I'm not sure if it will work with vs code  

7) Add the API token for **SLACK_BOT_TOKEN** in `.env` (Token is stored in 1Password)

8) You are done! Use the files in the local package for automation testing

> **Note** When testing sign up, you must enter your phone number into the file

---

### Instructions for Automation Testing on LambdaTest
1) Install [Node.js](https://nodejs.org/en)
2) Follow this [link](https://www.browserstack.com/guide/download-and-install-appium) to install Appium and its dependencies  
3) Navigate to [LambdaTest's Website](https://www.lambdatest.com/) and click **Dashboard**
    - Go to Automation → App Automation 
    - This is where all the automation tests are displayed  
4) Download [underpass](https://www.lambdatest.com/support/docs/underpass-tunnel-application/) and set up underpass for secure tunnel
  
5) **LambdaTest iteself has separate set up capabilities compared to Appium.** When you want to test with a new apk file, follow this [link](https://www.lambdatest.com/support/docs/upload-your-mobile-app/) and replace the value of the following line:
``` java
caps.setCapability("app", "lt://APP10160631101688091461122107");
```
- To set up the secure tunnel, change the contents of this line:
``` java
caps.setCapability("tunnelName", "DESKTOP-72RJ0L4");
```


6) Make sure JAVA_HOME and ANDROID_HOME are set up to use this program for automation
To be able to interact with the scanner and using IntelliJ, go to:
Help → Edit Custom VM Options  
Add "-Deditable.java.test.console=true" and restart IDE  
You should be able to input the otp after restarting IDE
> **Note** I did not test automation using vs code, so I'm not sure if it will work with vs code  

7) Add the API token for **LT_USERNAME**, **LT_ACCESS_KEY**, and **SLACK_BOT_TOKEN** in `.env` (Tokens are stored in 1Password)

8) Open **android_single.xml** and change the class name to whichever file you would like to test

9) You are done! Run the files inside the package lambdatest using **android_single.xml** and the test builds will show up on LambdaTest's dashboard

> **Note** When testing sign up, you must enter your phone number into the file

> **Warning** The AndroidSignUpTest does not work. The KYC part keeps crashing when trying to take a picture
---
### IMPORTANT
##### These settings are disabled in Developer options for the Xiaomi Phone
"Verify apps over USB"  
"Verify bytecode of debuggable apps"  
"Disable MIUI optimisations" 

##### These settings are enabled in Developer options
"Enable USB debugging (Security settings)"  
"Install via USB"  
#### There are certain parts where automation would not work
1) Entering the otp in the app (using Stag to test automation)
    - If you are using the Stag build, you must enter the otp you received into the terminal  
    - If you are using the Dev build, you will only have to automate Onfido   
2) Onfido  
    - You must manually take a picture of the HKID and selfie  

