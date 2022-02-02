[![N|](https://logodownload.org/wp-content/uploads/2017/05/marvel-logo-4-1.png)](https://logodownload.org/wp-content/uploads/2017/05/marvel-logo-4-1.png)
# MARVEL APP

## Previous steps

Install XCode 13.2

## How to run

1. Clone the repo
2. On project root folder run

```
open Marvel.xcodeproj
```

Open it and wait for to finish downloading packages.

## General Explanation

The project has a version of the Clean Swift architecture with its own components in addition to handling requests, custom views, strings, models

## Summary
- Modules
-- Base: Base module to avoid code duplication and vertical method access
-- Splash: Initial module where an initial request is made to validate the connection status.
-- CharacterList: Module where the characters are listed
-- CharacterDetailList: Module where it shows the detail of the character

- Custom: Reusable components throughout the app
- AppStrings: To optimize the location of Strings
- Helpers: Environment variable handling with potential to handle .plist encryption
- Network: Management and structure of requests by type
- Utils: for managing Constants among others

## Tests

UTest and UITest tests are included and have coverage, they have tests, so please feel free to run them.

## Swift Packege Manager Used

The app only uses RxSwift and RxCocoa

