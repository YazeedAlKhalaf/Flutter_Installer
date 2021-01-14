# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]

### Added

- Started using `file_selector` plugin

### Changed

- User-Agent now is a custom one when downloading the Flutter SDK as per Flutter Installer requirements
- Upgraded all packages to latest possible

### Fixed

- General bug fixes

### Removed

- Removed `file_chooser` plugin

## [0.0.6] - 2020-10-15

### Added

- DARK mode support
- Theming support
- Custom message when using `osascript` in macOS to gain administrator privileges

### Changed

- Refactored Windows Script
- Refactored Linux Script
- Refactored macOS Script
- Started using dev channel for all platforms

### Fixed

- Windows was not working, now it works after it is in alpha stage
- Windows was showing `cmd` when using the shell, now it has been fixed!
- Issue [#4](https://github.com/YazeedAlKhalaf/Flutter_Installer/issues/4) has been fixed!

### Removed

- `TermsOfServiceView` is not useful so it is now removed

## [0.0.5] - 2020-08-10

### Added

- Use `osascript` to get sudo password on macOS

### Fixed

- Bug where some times the `append-to-path.bat` file won't add to `PATH`
- Updated dependencies

### Removed

- Removed `sudoPassword` to `UserChoice` model
- Removed asking for Sudo Password on macOS only in `CustomizeStepView`

## [0.0.4] - 2020-08-05

### Added

- App logos beside them in `CustomizeView`
- Get download links of scripts dynamically so that an update won't be neccessay for getting script link

### Fixed

- Bug where some times the `append-to-path.bat` file won't add to `PATH`

## [0.0.3] - 2020-07-28

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
- Implemented notes by [Tao Dong](https://github.com/InMatrix) and [Will Larche](https://github.com/willlarche)

### Fixed

- Naming mistake in `CustomizeView`
- Borders of text fields in `CustomizeView`
- Small bugs here and there

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

[unreleased]: https://github.com/YazeedAlKhalaf/Split_It/compare/v0.0.6...HEAD
[0.0.6]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.6
[0.0.5]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.5
[0.0.4]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.4
[0.0.3]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.3
[0.0.2]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.2
[0.0.1]: https://github.com/YazeedAlKhalaf/Split_It/releases/tag/v0.0.1
