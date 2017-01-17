# OneSignalQml
OneSignal is a free push notification service for mobile apps. This package allows you to integrate OneSignal's native SDK functionality into your Qt/QML based iOS and Android applications.

## Installation

### Step One: Cloning
Installing OneSignalQml is easy, just add this Git repository as a submodule (or copy the contents of the repository) to your project.

If using the `git` command, you can add the submodule in one line:

```
git submodule add https://github.com/lukevear/OneSignalQml.git lib/OneSignalQml
```

### Step Two: Installing OneSignal
Natrually you're going to need to add the relevant OneSignal libraries to your project for this package to function.

On iOS, you can simple copy `OneSignal.framework` from the '*iOS_SDK/Framework*' folder in the official [OneSignal iOS Repository](https://github.com/OneSignal/OneSignal-iOS-SDK) to a destination within your project (personally I use `<project path>/lib/Frameworks`).

### Step Three: Qt Project Configuration
One you have completed the above steps, all that's left to make sure qmake and the compiler can find everything it needs. To achieve this, you'll need to include this package in your `.pro` file, like this (remember to change the path as appropiate):

```
include(lib/OneSignalQml/OneSignalQml.pri)
```

#### iOS Specific Steps
If developing for iOS, you'll need to let clang know where `OneSignal.framework` is located:

```
ios {
    # Include our Frameworks
    QMAKE_CXXFLAGS += -std=c++11 -stdlib=libc++ -F$$PWD/lib/Frameworks
    QMAKE_LFLAGS += -stdlib=libc++ -F$$PWD/lib/Frameworks
    
    # Include the OneSignal SDK
    LIBS += -lz -framework OneSignal
}
```

Once clang is able to find the framework, your then need to configure your `Info.plist` with the `remote-notification` background mode (a sample `Info.plist` is available in *tests/bundles/ios*). You then need to add the custom `Info.plist` to your `.pro` file so that when qmake generates an Xcode project it is automatically included:

```
ios {
    # Add our custom Info.plist
    QMAKE_INFO_PLIST = $$PWD/bundles/ios/Info.plist
}
```

#### Android Specific Steps
If developing for Android, you need to follow the instructions in section "1. Gradle Setup" on the official [Android SDK Documentation](https://documentation.onesignal.com/docs/android-sdk-setup). You only need to configure gradle - do not perform any other steps.
