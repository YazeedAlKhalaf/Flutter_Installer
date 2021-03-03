import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';
import 'package:stacked_services/stacked_services.dart';

final Utils _utils = locator<Utils>();
final LocalStorageService _localStorageService = locator<LocalStorageService>();
final ApiService _apiService = locator<ApiService>();
final SnackbarService _snackbarService = locator<SnackbarService>();

FlutterRelease flutterRelease;
String archiveName;
String tempDirName;
String distroName;

String appendToPathScriptName = 'append-to-path.sh';
Duration snackBarDuration = const Duration(seconds: 5);

Future<void> installOnMacOS({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On macOS');

  Shell myShell = shell;

  const double percentageMultiple = 0.06666666667;

  await _initializeVariables(
    percentage: percentageMultiple * 1,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _createShell(
    percentage: percentageMultiple * 2,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  myShell = await _cdToTempDirectory(
    percentage: percentageMultiple * 3,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _createFlutterInstallerTempDirectory(
    percentage: percentageMultiple * 4,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  myShell = await _cdToFlutterInstallerTempDirectory(
    percentage: percentageMultiple * 5,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _downloadFlutterSdkForMacOSWithCurl(
    percentage: percentageMultiple * 6,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _upzipDownloadedFlutterSdkForMacOS(
    percentage: percentageMultiple * 7,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _downloadScriptForAddingFlutterToPath(
    percentage: percentageMultiple * 8,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _runAddFlutterToPathScript(
    percentage: percentageMultiple * 9,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _installGit(
    percentage: percentageMultiple * 10,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installAndroidStudio(
    percentage: percentageMultiple * 11,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installIntelliJIDEA(
    percentage: percentageMultiple * 12,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installVisualStudioCode(
    percentage: percentageMultiple * 13,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _cleanup(
    percentage: percentageMultiple * 14,
    logger: logger,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _runDone(
    percentage: 1.0,
    logger: logger,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
}

Future<void> _initializeVariables({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Initializing');
  setPercentage(percentage);

  flutterRelease = await _apiService.getLatestRelease(
    flutterChannel: userChoice.flutterChannel,
    platform: FlutterReleasePlatform.macOS,
  );

  archiveName = _utils.getAnythingAfterLastSlash(flutterRelease.archive);
  logger.i('Archive Name: $archiveName');
  tempDirName = 'flutter_installer_${_utils.randomString(5)}';
  logger.i('Temp Directory Name: $tempDirName');
}

/// create a `shell`
Future<void> _createShell({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Creating shell');
  setPercentage(percentage);
  await fakeDelay();
  logger.i('Created Shell: ${shell.toString()}');
}

/// `cd` into Temp directory
Future<Shell> _cdToTempDirectory({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Changing directory to "temp"');
  setPercentage(percentage);
  await fakeDelay();
  shell.pushd(await _localStorageService.getTempDiretoryPath());
  logger.i('Change Directory to Temp');
  return shell;
}

/// create `flutter_installer` temp directory
Future<void> _createFlutterInstallerTempDirectory({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Creating "$tempDirName" directory');
  setPercentage(percentage);
  await fakeDelay();
  await shell.run('''
    mkdir $tempDirName
    ''');
  logger.i('Created $tempDirName');
}

/// `cd` into `flutter_installer` directory
Future<Shell> _cdToFlutterInstallerTempDirectory({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Changing directory to "$tempDirName"');
  setPercentage(percentage);
  await fakeDelay();
  shell.pushd(tempDirName);
  logger.i('Change directory to $tempDirName');
  return shell;
}

/// download Flutter SDK for macOS using `curl`
Future<void> _downloadFlutterSdkForMacOSWithCurl({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading Flutter SDK for macOS\n(This may take some time)',
  );
  setPercentage(percentage);
  await fakeDelay();
  logger.i(
    'Started Download of "$archiveName" from "${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}"',
  );
  await shell.run('''
    curl -o $archiveName "${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}"
    ''');
  logger.i(
    'Finished Download of "$archiveName" from "${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}"',
  );
}

/// use `tar` to unzip the downloaded file
Future<void> _upzipDownloadedFlutterSdkForMacOS({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Unzipping Flutter SDK to installation path\n(This might take some time)',
  );
  setPercentage(percentage);

  /// wait for file to be installed fully
  /// sometimes it breaks of you don't wait
  await fakeDelay(seconds: 6);
  logger.i(
    'Started Extracting of $archiveName from ${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}',
  );
  await shell.run('''
    tar -xvf "${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$archiveName" -C "${userChoice.installationPath}"
    ''');
  logger.i(
    'Finished Extracting of $archiveName from ${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}',
  );
}

/// download `append-to-path.sh`
Future<void> _downloadScriptForAddingFlutterToPath({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading Script for adding to PATH',
  );
  setPercentage(percentage);
  await fakeDelay();
  final ScriptRelease appendToPathScriptRelease =
      await _apiService.getLatestAppendToPathScript();
  final String appendToPathScriptLink =
      appendToPathScriptRelease.downloadLinks.macos;
  logger.i(
    '''
Started Downloading of $appendToPathScriptName from $appendToPathScriptLink''',
  );
  await shell.run('''
  curl -o $appendToPathScriptName -L $appendToPathScriptLink
  ''');
  logger.i(
    '''
Finished Downloading of $appendToPathScriptName from $appendToPathScriptLink''',
  );
}

/// add `flutter` to the `PATH`
Future<void> _runAddFlutterToPathScript({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Adding Flutter SDK to the PATH',
  );
  setPercentage(percentage);
  await fakeDelay();
  final String flutterPath = '${userChoice.installationPath}/flutter/bin';
  await shell.run('''
  osascript -e 'do shell script "bash 
  ${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$appendToPathScriptName $flutterPath" with prompt 
  "Flutter Installer needs administrator privileges to add Flutter to your PATH" with administrator privileges'
  ''');
  logger.i(
    'Added Flutter to PATH',
  );
}

Future<void> _installGit({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  Future<void> _downloadGit() async {
    /// install `git` for macOS
    setCurrentTaskText(
      'Downloading Git for macOS\n(This may take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    logger.i(
      'Started Downloading Git For macOS',
    );
    await shell.run('''
    brew install git
    ''');
    logger.i(
      'Finished Downloading Git For macOS',
    );
  }

  try {
    if (userChoice.installGit) {
      await _downloadGit();
    }

    if (!userChoice.installGit) {
      setCurrentTaskText(
        'Skipping Downloading Git for macOS',
      );
      setPercentage(percentage);
      await fakeDelay();
    }
  } on ShellException catch (shellException) {
    logger.e(shellException);
    _snackbarService.showSnackbar(
      message: shellException.message,
    );
  } catch (exception) {
    logger.e(exception);
    _snackbarService.showSnackbar(
      message: 'Something went wrong!',
    );
  }
}

Future<void> _installAndroidStudio({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  final AppRelease androidStudioRelease =
      await _apiService.getLatestAndroidStudioRelease();
  final String androidStudioName = _utils
      .getAnythingAfterLastSlash(androidStudioRelease.downloadLinks.macos);
  final String androidStudioDownloadLink =
      androidStudioRelease.downloadLinks.macos;

  Future<void> _downloadAndroidStudio() async {
    /// download `Android Studio` for macOS
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();

    logger.i(
      'Started Downloading Android Studio For macOS',
    );
    await shell.run('''
      curl -o $androidStudioName -L "$androidStudioDownloadLink"
      ''');
    logger.i(
      'Finished Downloading Android Studio For macOS',
    );
  }

  Future<void> _startAndroidStudio() async {
    /// start `Android Studio`
    setCurrentTaskText(
      '''
Running $androidStudioName, Follow the steps there\nIf nothing showed up, open finder and you'll find it mounted''',
    );
    setPercentage(percentage + 0.01);
    await fakeDelay();
    logger.i(
      'Started Android Studio Latest Version',
    );
    await shell.run('''
    open "${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$androidStudioName"
    ''');
    logger.i(
      'Finished Android Studio Latest Version',
    );
  }

  try {
    if (userChoice.installAndroidStudio) {
      await _downloadAndroidStudio();
      await _startAndroidStudio();
    }

    if (!userChoice.installAndroidStudio) {
      setCurrentTaskText(
        'Skipping Downloading Android Studio Latest Version for macOS',
      );
      setPercentage(percentage);
      await fakeDelay();
    }
  } on ShellException catch (shellException) {
    logger.e(shellException);
    _snackbarService.showSnackbar(
      message: shellException.message,
    );
  } catch (exception) {
    logger.e(exception);
    _snackbarService.showSnackbar(
      message: 'Something went wrong!',
    );
  }
}

Future<void> _installIntelliJIDEA({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  final AppRelease intelliJIDEARelease =
      await _apiService.getLatestIntelliJIDEARelease();
  final String intelliJIDEAName =
      _utils.getAnythingAfterLastSlash(intelliJIDEARelease.downloadLinks.macos);
  final String intelliJIDEADownloadLink =
      intelliJIDEARelease.downloadLinks.macos;

  Future<void> _downloadIntelliJIDEA() async {
    /// download `IntelliJ IDEA` for macOS
    setCurrentTaskText(
      'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();

    logger.i(
      '''
Started Downloading IntelliJ IDEA For macOS from "$intelliJIDEADownloadLink"''',
    );
    await shell.run('''
      curl -o $intelliJIDEAName -L "$intelliJIDEADownloadLink"
      ''');
    logger.i(
      '''
Finished Downloading IntelliJ IDEA For macOS from "$intelliJIDEADownloadLink"''',
    );
  }

  Future<void> _startIntelliJIDEA() async {
    /// start `IntelliJIDEA`
    setCurrentTaskText(
      '''
Running $intelliJIDEAName, Follow the steps there\nIf nothing showed up, open finder and you'll find it mounted''',
    );
    setPercentage(percentage + 0.01);
    await fakeDelay();
    logger.i(
      'Started IntelliJIDEA Latest Version',
    );
    await shell.run('''
    open "${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$intelliJIDEAName"
    ''');
    logger.i(
      'Finished IntelliJIDEA Latest Version',
    );
  }

  try {
    if (userChoice.installIntelliJIDEA) {
      await _downloadIntelliJIDEA();
      await _startIntelliJIDEA();
    }

    if (!userChoice.installIntelliJIDEA) {
      setCurrentTaskText(
        'Skipping Downloading IntelliJ IDEA Latest Version for macOS',
      );
      setPercentage(percentage);
      await fakeDelay();
    }
  } on ShellException catch (shellException) {
    logger.e(shellException);
    _snackbarService.showSnackbar(
      message: shellException.message,
    );
  } catch (exception) {
    logger.e(exception);
    _snackbarService.showSnackbar(
      message: 'Something went wrong!',
    );
  }
}

Future<void> _installVisualStudioCode({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  final AppRelease visualStudioCodeRelease =
      await _apiService.getLatestVisualStudioCodeRelease();
  final String visualStudioCodeDownloadLink =
      visualStudioCodeRelease.downloadLinks.macos;
  const String visualStudioCodeName = 'code-stable-darwin.zip';

  Future<void> _downloadVisualStudioCode() async {
    /// install `Visual Studio Code` for macOS
    setCurrentTaskText(
      '''
Downloading Visual Studio Code Latest Version\n(This might take some time)''',
    );
    setPercentage(percentage);
    await fakeDelay();
    logger.i(
      '''
Started Downloading Visual Studio Code For macOS from "$visualStudioCodeDownloadLink"''',
    );
    await shell.run('''
      mkdir vscode
      curl -o ./vscode/$visualStudioCodeName -L "$visualStudioCodeDownloadLink"
      ''');
    logger.i(
      '''
Finished Downloading Visual Studio Code For macOS from "$visualStudioCodeDownloadLink"''',
    );
  }

  Future<void> _unzipVisualStudioCode() async {
    /// use `tar` to unzip the downloaded file
    setCurrentTaskText('''
Unzipping Visual Studio Code Latest Version to installation path\n(This might take some time)''');
    setPercentage(percentage + 0.01);
    await fakeDelay();
    logger.i(
      '''
Started Extracting of "$visualStudioCodeName" from "$visualStudioCodeDownloadLink"''',
    );
    await shell.run('''
      tar -xvf "${await _localStorageService.getTempDiretoryPath()}/$tempDirName/vscode/$visualStudioCodeName"
      ''');
    logger.i(
      '''
Finished Extracting of "$visualStudioCodeName" from "$visualStudioCodeDownloadLink"''',
    );
  }

  Future<void> _moveVisualStudioCode() async {
    /// move `Visual Studio Code.app` to applications
    setCurrentTaskText(
      'Moving Visual Studio Code.app to Applications',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
    logger.i(
      'Started Moving Visual Studio Code Latest Version',
    );
    await shell.run('''
      osascript -e 'do shell script "cp -r ${await _localStorageService.getTempDiretoryPath()}/$tempDirName/vscode/.  ~/Applications" with prompt "Flutter Installer needs administrator privileges to be able to copy Visual Studio Code to Applications folder" with administrator privileges'
      ''');
    logger.i(
      'Finished Moving Visual Studio Code Latest Version',
    );
  }

  try {
    if (userChoice.installVisualStudioCode) {
      await _downloadVisualStudioCode();
      await _unzipVisualStudioCode();
      await _moveVisualStudioCode();
    }

    if (!userChoice.installVisualStudioCode) {
      setCurrentTaskText(
        'Skipping Downloading Visual Studio Code Latest Version for macOS',
      );
      setPercentage(percentage);
      await fakeDelay();
    }
  } on ShellException catch (shellExecption) {
    if (shellExecption.message.contains(
      '''
osascript -e 'do shell script "cp -r /Users''',
    )) {
      _snackbarService.showSnackbar(
        duration: snackBarDuration,
        message: '''
We couldn't get administrator privileges, copying Visual Studio Code to Applications folder failed!''',
      );
    }
  } catch (exception) {
    logger.e(exception);
    _snackbarService.showSnackbar(
      message: 'Something went wrong!',
    );
  }
}

/// cleaning up
Future<void> _cleanup({
  @required double percentage,
  @required Logger logger,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Cleaning Up!',
  );
  setPercentage(percentage);
  await fakeDelay();
  logger.i(
    'Finished Cleaning Up!',
  );
}

/// Done 🚀😎
Future<void> _runDone({
  @required double percentage,
  @required Logger logger,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    '''
You're Done! 🚀😎''',
  );
  setPercentage(percentage);
  await fakeDelay();
  logger.i(
    'Finished installing Flutter for macOS!',
  );
}
