# Flutter Template

A template for new Flutter project.

# Features
- Multi platforms
  - Tested on Android API 32 (Pixel 4a)
- Screens
  - Welcome screen
  - Login / SignUp Screen
  - List Screen
- Basic components
  - Button
  - Card container
  - Scrollable page container with padding
- l10n locales support
  - `zh-TW`
- Services
  - Dio
  - Sample fake data
- Data model examples
- Theming
  - Using Material 3
- Custom Icon Support
- Routing: Navigator
  - Navigation Tab
- Utils
  - Datetime extension
  - String extension
  - Password and email validation
  
## Roadmap
1. Test build on ios device
2. Test dio backend connection
3. Form screen and components
4. Detailed Login/SignUp screen
5. Documentation for utils api and components
6. Deep linking
7. Notification
8. Local storage
9. Web support
10. Local database
11. In-app purchase or payment

## Project Structure
```
flutter-template
├───build
├───assets
│   ├───icons
│   └───images
├───lib
│   ├───generated
│   │   └───intl
│   ├───l10n
│   ├───models
│   │   └───api
│   ├───services
│   ├───theme
│   ├───utils
│   └───widgets
│       ├───components
│       └───screens
├───test
├───android
├───ios
├───linux
├───macos
├───web
└───windows
```

# Setup
## Prequisites
1. [Install Flutter](https://docs.flutter.dev/get-started/install)
2. 

## Setup
1. `git clone` this repository
2. `flutter pub get` to get all dependencies

## Customization
### Change App Name
1. Replace all `flutter_template` with the new app name (separate word by underscore `_`)
2. Replace `title` in `lib/utils/config.dart`
3. Change `com.example.flutter_template` (android) and `com.example.flutterTemplate` (ios) to the new package name

### Change App Icon
1. Replace `assets/icons/icon.png` with the new icon image
2. `flutter pub run flutter_launcher_icons:main`

### Localization
To add string value to existing locale (zh-TW): 

1. Get [Flutter Intl Extension](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) (for VS Code)
2. Add key-value pair in `lib/i10n/intl_zh_Hant_TW.arb`
3. Save and the extension will generate `.dart` code automatically
   
For adding locales or further information, please refer to the documentation at the [extension page](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl).

## Production
1. `flutter build android`
2. 
   
## Upgrade SDK
Update to newer flutter version:
1. `flutter channel stable`
2. `flutter upgrade`
3. `flutter pub upgrade`