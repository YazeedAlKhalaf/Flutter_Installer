import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:process_run/shell.dart';
import 'package:stacked_services/stacked_services.dart';

class InstallingViewModel extends CustomBaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final Utils _utils = locator<Utils>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final ApiService _apiService = locator<ApiService>();

  UserChoice _userChoice;
  UserChoice get userChoice => _userChoice;

  double _percentage;
  double get percentage => _percentage;
  void setPercentage(double newValue) {
    _percentage = newValue;
    notifyListeners();
  }

  String _currentTaskText = '';
  String get currentTaskText => _currentTaskText;
  void setCurrentTaskText(String newValue) {
    _currentTaskText = newValue;
    notifyListeners();
  }

  Future<void> initialize({
    @required UserChoice userChoice,
  }) async {
    setPercentage(0.0);
    setCurrentTaskText('Preparing...');
    getVariables(
      userChoice: userChoice,
    );
    print('Install Function started');
    await install();
    print('Install Function ended');
  }

  getVariables({
    @required UserChoice userChoice,
  }) {
    _userChoice = userChoice;
  }

  Future<bool> showCancelConfirmationDialog() async {
    DialogResponse dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are You Sure? 😢',
      description: 'Are You Sure You Wanna Cancel This Download? 😢',
      cancelTitle: 'No, Thanks God 🙏',
      confirmationTitle: 'Yes, I\'m Pretty Sure 🚀',
      dialogPlatform: DialogPlatform.Material,
    );

    return dialogResponse.confirmed;
  }

  Future<void> install() async {
    // if (!Platform.isWindows || !Platform.isMacOS || !Platform.isLinux) {
    //   _snackbarService.showSnackbar(
    //     title: 'Unsupported Operating System',
    //     message: '${Platform.operatingSystem} is not supported!',
    //     iconData: Icons.close,
    //   );
    //   return;
    // }

    if (Platform.isWindows) {
      await installOnWindows();
    }

    if (Platform.isMacOS) {
      await installOnMacOS();
    }

    if (Platform.isLinux) {
      await installOnLinux();
    }
  }

  Future<void> installOnWindows() async {
    print('Install On Windows');

    FlutterRelease flutterRelease = await _apiService.getLatestRelease(
      flutterChannel: userChoice.flutterChannel,
      platform: FlutterReleasePlatform.windows,
    );

    final String archiveName =
        _utils.getAnythingAfterLastSlash(flutterRelease.archive);
    final String tempDirName = 'flutter_installer_${_utils.randomString(5)}';

    /// create a `shell`
    setCurrentTaskText('Creating shell');
    setPercentage(0.1);
    await fakeDelay();
    Shell shell = Shell();

    /// `cd` into Temp directory
    setCurrentTaskText('Changing directory to "temp"');
    setPercentage(0.2);
    await fakeDelay();
    shell = shell.pushd(await _localStorageService.getTempDiretoryPath());

    /// create `flutter_installer` directory
    setCurrentTaskText('Creating "$tempDirName" directory');
    setPercentage(0.3);
    await fakeDelay();
    await shell.run('''
    mkdir $tempDirName
    ''');

    /// `cd` into `flutter_installer` directory
    setCurrentTaskText('Changing directory to "$tempDirName"');
    setPercentage(0.4);
    await fakeDelay();
    shell = shell.pushd('$tempDirName');

    /// download Flutter SDK for Windows using `curl`
    setCurrentTaskText(
      'Downloading Flutter SDK for Windows\n(This may take some time)',
    );
    setPercentage(0.5);
    await fakeDelay();
    await shell.run('''
    curl -o $archiveName "${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}"
    ''');

    /// use `tar` to unzip the downloaded file
    setCurrentTaskText(
        'Unzipping Flutter SDK to installation path\n(This might take some time)');
    setPercentage(0.6);
    await fakeDelay();
    await shell.run('''
    tar -xf ${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$archiveName -C ${userChoice.installationPath}
    ''');

    /// add `flutter` to the `PATH`
    setCurrentTaskText(
      'Adding Flutter SDK to the PATH',
    );
    setPercentage(0.7);
    await fakeDelay();
    // TODO(yazeed): Add Flutter to PATH

    if (_userChoice.installGit) {
      /// install `git` for windows using
      setCurrentTaskText(
        'Downloading Git for Windows\n(This may take some time)',
      );
      setPercentage(0.8);
      await fakeDelay();
      GithubReleaseAsset githubReleaseAsset =
          await _apiService.getLatestGitForWindowsRelease();
      String gitDownloadName = _utils
          .getAnythingAfterLastSlash(githubReleaseAsset.browserDownloadUrl);
      await shell.run('''
      curl -o $gitDownloadName -L "${githubReleaseAsset.browserDownloadUrl}"
      ''');

      /// run the `.exe` installer
      setCurrentTaskText(
        'Running $gitDownloadName, Follow the steps there',
      );
      setPercentage(0.9);
      await fakeDelay();
      await shell.run('''
      start /wait ${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$gitDownloadName
      ''');
    }

    /// Done 🚀😎
    setCurrentTaskText(
      'You\'re Done! 🚀😎',
    );
    setPercentage(1.0);
    await fakeDelay();

    // if (userChoice.installAndroidStudio) {
    //   setCurrentTaskText(
    //     'Downloading Android Studio Latest Version\n(This might take some time)',
    //   );
    // }

    // if (userChoice.installVisualStudioCode) {
    //   setCurrentTaskText(
    //     'Downloading Visual Studio Code Latest Version\n(This might take some time)',
    //   );
    // }

    // if (userChoice.installIntelliJIDEA) {
    //   setCurrentTaskText(
    //     'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    //   );
    // }
  }

  Future<void> installOnMacOS() async {
    print('Install On MacOS');
  }

  Future<void> installOnLinux() async {
    print('Install On Linux');
  }
}
