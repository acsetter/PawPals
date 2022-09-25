# CSC 450 - Team Project

## Dependencies:
* [Firebase Auth](https://firebase.google.com/docs/auth/flutter/start)
* [Firebase Storage](https://firebase.google.com/docs/storage/flutter/start)
* [Firebase Database](https://firebase.google.com/docs/database/flutter/start)
* [deep_pick](https://pub.dev/packages/deep_pick)
* [GetX](https://pub.dev/packages/get)

## Getting Started:

**Step(s) 1:**

* Ensure android studio is downloaded with the flutter plugin installed.
* To link your Github account to Android Studio, go to *File* > *Settings...* > *Version Control* > 
  *Github* > *Add Account* > *Generate*.
* Next, got to your terminal and make sure you are in the root directory.
* Finally, pull the most recent changes from Github using the `git pull` command.

**Step 2:**

* Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

## Running the app:
Although the Android Emulator is painful to use, it is good to have at least one installed for testing. 
Here are setup instructions: [android-emulator-setup](https://llayman.github.io/uncw-csc315/labs/windows-setup.html#android-emulator-setup). 
At the top-right of Android Studio, you will see a green play button and, next to it, device selection. 
While developing, I suggest you install Google Chrome and use `CHROME (WEB)` as the selected device.

**Making Chrome look like a phone:**

After the app opens in chrome, press `F12`, then press `CTRL` + `Shift` + `M`'. 
At the top-middle of the tab, you will see a dropdown selection to emeulate the screen dimensions of 
any device; pick an Android phone is wise. You can hot reload changes within Android Studio by pressing
the lightning-icon or the refresh-icon in the console while the app is running. Any huge crashes or
changes made outside the `lib` folder will require a full restart of the app.

## Team Members
* [Morgan Glisson](https://github.com/morganglis)
* [Aaron Csetter](https://github.com/acsetter)
* [Austin Whittaker](https://github.com/AustinWhittaker)
* [Johnathan Smith](https://github.com/JohnathanASmith)
* [Savannah Evonko](https://github.com/SavannahEvonko)
