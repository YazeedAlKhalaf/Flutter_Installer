# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added `sudoPassword` to `UserChoice` model
- Added asking for Sudo Password on macOS only in `CustomizeStepView`
- macOS Script:
  - Install Flutter SDK
  - Unzip Flutter SDK
  - Add Flutter SDK to PATH
  - Install Git (requires `brew`)
  - Install Android Studio
  - Install IntelliJ IDEA
  - Install Visual Studio Code

### Fixed

- Naming mistake in `CustomizeView`
- Borders of text fields in `CustomizeView`

### Removed

- Removed sandbox mode from macOS

## [0.0.2] - 2020-07-23

### Added

- `Customize Screen: Show Advanced` Button
- Back button on `Summary` Screen
- `scripts` folder in `installing` step folder for having cleaner code.
- Default installation path in customize screen.
- `TextLink` widget
- Linux Script:
  - Install Flutter SDK
  - Unzip Flutter SDK
  - Add FLutter SDK to PATH
  - Install Git (with common package managers)
  - Install Android Studio
  - Install IntelliJ IDEA
  - Install Visual Studio

### Fixed

- VS Code installer for Windows was being saved with no extenstion, Now it is being saved with `.exe` extension
- Spelling Errors

## [0.0.1] - 2020-07-20

### Added

- UI
- Windows Support (Script Part Fully Done)
- Fonts: (Roboto, Roboto Mono)

[unreleased]: https://github.com/YazeedAlKhalaf/Split_It/compare/v0.0.2...HEAD
[0.0.2]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.2
[0.0.1]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.1
