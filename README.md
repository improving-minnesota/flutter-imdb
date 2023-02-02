# flutter-imdb

A sample project using the IMDB API

## Getting Started

1. Install Flutter - https://docs.flutter.dev/get-started/install
1. Run `flutter doctor` - ensure all the red 'x' issues are resolved.
   1. Intellij or Android Studio is installed
   1. Android SDK installed
   1. Xcode is installed (if you want to run on iOS)
   1. It may be necessary to install cocoapods through homebrew (if you want to run on iOS) (`brew install cocoapods`) 
1. Create emulators / simulators as necessary
1. You will need an IMDB API Key to actually use the app


## Dev Things

Command to generate mockito mocks (execute in base project directory)
```shell
flutter packages pub run build_runner build --delete-conflicting-outputs
```

Possibly need these libraries for a native linux app:
```shell
sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
sudo apt install libsecret-1-dev libjsoncpp-dev libsecret-1-0
```