# CSC 450 - Team Project (PawPals)
> A pet adoption application built for Android.

## Dependencies:
* [Firebase Auth](https://firebase.google.com/docs/auth/flutter/start)
* [Firebase Storage](https://firebase.google.com/docs/storage/flutter/start)
* [Firebase Firestore](https://firebase.google.com/docs/firestore)
* [deep_pick](https://pub.dev/packages/deep_pick)
* [GetX](https://pub.dev/packages/get)
* [GeoHash Flutter](https://pub.dev/packages/flutter_geo_hash)
* [Flutter Location Plugin](https://pub.dev/packages/location)
* [Bloc](https://pub.dev/packages/flutter_bloc)
* [Cached Network Image](https://pub.dev/packages/cached_network_image)
* [Geolocator](https://pub.dev/packages/geolocator)
* [URL Launcher](https://pub.dev/packages/url_launcher)
* [Equitable](https://pub.dev/packages/equatable)

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
I recommend installing the Pixel 5 with API version 32 and 3 GB of internal storage (configurable under advanced settings).
Here are setup instructions: [android-emulator-setup](https://llayman.github.io/uncw-csc315/labs/windows-setup.html#android-emulator-setup). 
At the top-right of Android Studio, you will see a green play button and, next to it, device selection. 
While developing, I suggest using an actual Android device.


## Testing
As explained [here](https://github.com/UNCW-CSC-450/csc450fa22-project-group-8/issues/66), integration testing
doesn't seem to be working on Android with multidex enabled, so testing is limited to only Widget tests.

To run all Widget tests, ensure you are in the project's root directory and run:
```
flutter test
```
Optionally, you can run specific tests by specifying the name of the test file:
```
flutter test file_name.dart
```

#### Testing With Coverage
There are command line methods available, but they are not well-supported on Windows. 
For coverage testing in Android Studio, create a new run configuration similar to the following example:
![image](https://user-images.githubusercontent.com/39916941/205510036-e95acee6-3946-4e63-8b2d-3dc59b9f7965.png)
Then, run the configuration with coverage by clicking the 'run with coverage' button:
![image](https://user-images.githubusercontent.com/39916941/205510205-65f0085d-30f0-4528-9ddb-7d995ac25f7d.png)

## Team Members
* [Morgan Glisson](https://github.com/morganglis)
* [Aaron Csetter](https://github.com/acsetter)
* [Austin Whittaker](https://github.com/AustinWhittaker)
* [Johnathan Smith](https://github.com/JohnathanASmith)
* [Savannah Evonko](https://github.com/SavannahEvonko)
