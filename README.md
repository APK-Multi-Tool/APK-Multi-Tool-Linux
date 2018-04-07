# Apk Multi Tool

**I am currently working on a major update to the apk manager application as well and changing the name to APK Multi-Tool with some new added features and also to fix some issues with some code errors.**

I am also changing a lot of the features as well since a lot of the code has been outdated for a while.
I have updated all the files and modified Apk manager's Scripts to fix many user reported bugs from Daneshm90 apk manager which he had written a simple script to ease the process of editing apks. Got a lot of downloads so thought its in demand 
Whether you're doing basic image editing or editing the smali or xml files, on average u have to use (Brut.all or JF's smali/baksmali) awesome tool to extract the apk, edit it, then sign the apk and then adb push/install it. This process is quite tiresome if you are testing a method that needs fine tweaking.
This script should make the process a LOT smoother.
Theres an option of compiling/signing/installing all in one step 

**Thanks:**

* Goes to Daneshm90 the Original Writer of APK Manager
* Goes to Brut.all for his awesome tool.
* Goes to JF for ofcourse, smali/baksmali

---

### Features: 
- Added framework dependent decompiling (For non propietary rom apks). (Option 10). Checks whether the dependee apk u selected is correct.
- Allows multiple projects to be modified, switch to and from.
- Allows to modify system apk's using apktool but ensures maximum compatibility in terms of signature / manifest.xml
- Batch optimize apk (Zipalign,optipng,or both)
- Batch Ogg optimization
- Batch install apk from script (option 16)
- Compression level selector (monitor status above menu)
- Error detection. Checks if error occurred anytime u perform a task, and reports it
- Extract, Zip apk's.
- Incorporates brut.all's apktool
- Improved syntax of questions/answers
- Logging on/off has been removed. Instead a log.txt is created which logs the activities of the script organized using time/date headers
- Optimize pngs (ignores .9.pngs)
- Pull apk from phone into modding environment.
- Push to specific location on phone
- Quick sign an apk (Batch mode supported)
- Read log (Option 21)
- Sign apks
- Supports batch installation, so if u drag multiple apks into the script (not while its running) it will install them all for u. U can ofcourse drag a single apk as well 
- User can change the max java heap size (only use if certain large apks get stuck when decompiling/compiling apks) (Option 16)
- U can now set this script as ur default application for apks. When u do, if u double click any apk it will install it for u. 
- Zipalign apks
- Much Much More.

---

### Installing APK Multi-Tool

**Requirements:**

- Java 1.7 
- Adb

**Instructions (Linux):**

- Create a folder in your sdk called "APK-Multi-Tool" and put the contents of the extracted APK-Multi-Tool into it or Rename the extracted APK-Multi-Tool folder to just APK-Multi-Tool and put it into the sdk folder.
- Go to the the "sdk/APK-Multi-Tool" folder and rename "Script.sh" to "script.sh".
- Go into the "other" folder, right click on one executable file at a time, select properties, go to "permissions" in the new window and check the "allow file to be run as a program" box (do this with all the executables/.exe's).
- Open a terminal in the APK-Multi-Tool folder (or type in terminal: cd "PATH TO THE script.sh"). Type in:
  chmod 755 script.sh
- chmod 755 all files inside other folder. (thanks for the tip bkmo  )
- Install "sox": Open the software center of the linux service and searched for sox. Once installed you will have SOX working
- To add the path to your folder open up a terminal and type in:
  sudo su
  PATH=$PATH:/THE PATH TO YOUR "SCRIPT.SH"
  (for me this looks like the following)
  PATH=$PATH:/home/username/sdk/APK-Multi-Tool
- Export PATH:Open up a terminal in the APK-Multi-Tool folder (or type in terminal: cd "PATH TO THE script.sh") and type in:
  export PATH={PATH}:/PATH TO Your SDK/sdk/platform-tools/adb
  (for me this looks like the following)
  export PATH={PATH}:/home/username/sdk/platform-tools
  ("username" is the user name that appears on your computer).
- Now open a terminal in the APK-Multi-Tool folder (or type in terminal: cd "PATH TO THE script.sh") and type in:
  ./script.sh
- You should now have a running APK-Multi-Tool.

---
### Usage

**Instructions (Linux):**

- Place apk in appropriate folder (Any filename will work, if running for first time folders will not be there, you must run and then the folders will be created) 
- Open terminal in the APK-Multi-Tool folder (or type in terminal: cd "PATH TO THE script.sh")
- Run script by typing:
 ./script.sh
- Minimize the script
- Edit files inside the out folder
- Maximize the script

- Note: .jar files need to be renamed to .apk, then put in modding folder

**Got problems ?**

1. Make sure your path has no spaces
2. Your filename has no wierd characters
3. Java/adb are in your path
4. It's not a proprietary rom's apk (aka Sense,Motorola,Samsung) (If u are, then use option 11 and drag the required framework, eg com.htc.resources, twframework-res...etc)
5. It's not a themed apk (if it is, expect .9 png errors, use as close to stock as possible)
6. Look at the log to know whats happening
7. If all else fails, post as much info as possible and we will try to assist you.
