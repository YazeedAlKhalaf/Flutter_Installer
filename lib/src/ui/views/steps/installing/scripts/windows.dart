import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/utils/constants.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';

final Utils _utils = locator<Utils>();
final LocalStorageService _localStorageService = locator<LocalStorageService>();
final ApiService _apiService = locator<ApiService>();

FlutterRelease flutterRelease;
String archiveName;
String tempDirName;

String appendToPathScriptName = "append-to-path.bat";

Future<void> installOnWindows({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On Windows');

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

  await _downloadFlutterSdkForWindowsWithCurl(
    percentage: percentageMultiple * 6,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _upzipDownloadedFlutterSdkForWindows(
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
  await _addFlutterToPath(
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
  await _installVisualStudioCode(
    percentage: percentageMultiple * 12,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installIntelliJIDEA(
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
    platform: FlutterReleasePlatform.windows,
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
  shell = shell.pushd(await _localStorageService.getTempDiretoryPath());
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
  shell = shell.pushd('$tempDirName');
  logger.i('Change directory to $tempDirName');
  return shell;
}

/// download Flutter SDK for Windows using `curl`
Future<void> _downloadFlutterSdkForWindowsWithCurl({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading Flutter SDK for Windows\n(This may take some time)',
  );
  setPercentage(percentage);
  await fakeDelay();
  logger.i(
    'Started Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
  await shell.run('''
    curl -H \"User-Agent: ${Constants.flutterInstallerUserAgent}\" -o $archiveName \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"
    ''');
  logger.i(
    'Finished Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
}

/// use `tar` to unzip the downloaded file
Future<void> _upzipDownloadedFlutterSdkForWindows({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
      'Unzipping Flutter SDK to installation path\n(This might take some time)');
  setPercentage(percentage);

  /// wait for file to be installed fully
  /// sometimes it breaks of you don't wait
  await fakeDelay(seconds: 6);
  logger.i(
    'Started Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
  await shell.run('''
    C:\\Windows\\System32\\tar.exe -xvf \"${await _localStorageService.getTempDiretoryPath()}\\$tempDirName\\$archiveName\" -C \"${userChoice.installationPath}\"
    ''');
  logger.i(
    'Finished Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
}

/// download `.bat` file for adding `flutter` to `PATH`
Future<void> _downloadScriptForAddingFlutterToPath({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading Script for adding Flutter SDK to PATH',
  );
  setPercentage(percentage);
  await fakeDelay();
  ScriptRelease appendToPathScriptRelease =
      await _apiService.getLatestAppendToPathScript();
  String appendToPathScriptLink =
      appendToPathScriptRelease.downloadLinks.windows;
  logger.i(
    'Started Downloading of \"$appendToPathScriptName\" from \"$appendToPathScriptLink\"',
  );
  await shell.run("""
    curl -o $appendToPathScriptName -L \"$appendToPathScriptLink\"
    """);
  logger.i(
    'Finished Downloading of \"$appendToPathScriptName\" from \"$appendToPathScriptLink\"',
  );
}

/// add `flutter` to the `PATH`
Future<void> _addFlutterToPath({
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
  String flutterPath = "${userChoice.installationPath}\\flutter\\bin";
  await shell.run("""
    $appendToPathScriptName $flutterPath
    """);
  logger.i(
    'Added Flutter to PATH',
  );
}

/// install `git` for windows
///  run the `.exe` installer
Future<void> _installGit({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  if (userChoice.installGit) {
    setCurrentTaskText(
      'Downloading Git for Windows\n(This may take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    GithubReleaseAsset githubReleaseAsset =
        await _apiService.getLatestGitForWindowsRelease();
    String gitDownloadName =
        _utils.getAnythingAfterLastSlash(githubReleaseAsset.browserDownloadUrl);
    logger.i(
      'Started Downloading Git For Windows from \"${githubReleaseAsset.browserDownloadUrl}\"',
    );
    await shell.run('''
      curl -o $gitDownloadName -L "${githubReleaseAsset.browserDownloadUrl}"
      ''');
    logger.i(
      'Finished Downloading Git For Windows from \"${githubReleaseAsset.browserDownloadUrl}\"',
    );

    setCurrentTaskText(
      'Running $gitDownloadName, Follow the steps there',
    );
    setPercentage(percentage + 0.03);
    await fakeDelay();
    logger.i(
      'Started $gitDownloadName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
    await shell.run('''
      start "${await _localStorageService.getTempDiretoryPath()}\\$tempDirName\\$gitDownloadName"
      ''');
    logger.i(
      'Finished $gitDownloadName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
  }

  if (!userChoice.installGit) {
    setCurrentTaskText(
      'Skipping Downloading Git for Windows',
    );
    setPercentage(percentage);
    await fakeDelay();
  }
}

/// install `Android Studio` for windows
/// run the `.exe` installer
Future<void> _installAndroidStudio({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  if (userChoice.installAndroidStudio) {
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    AppRelease androidStudioRelease =
        await _apiService.getLatestAndroidStudioRelease();
    String androidStudioName = _utils
        .getAnythingAfterLastSlash(androidStudioRelease.downloadLinks.windows);
    logger.i(
      'Started Downloading Android Studio For Windows from \"${androidStudioRelease.downloadLinks.windows}\"',
    );
    await shell.run('''
      curl -o $androidStudioName -L "${androidStudioRelease.downloadLinks.windows}"
      ''');
    logger.i(
      'Finished Downloading Android Studio For Windows from \"${androidStudioRelease.downloadLinks.windows}\"',
    );

    setCurrentTaskText(
      'Running $androidStudioName, Follow the steps there',
    );
    setPercentage(percentage + 0.03);
    await fakeDelay();
    logger.i(
      'Started $androidStudioName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}\\$tempDirName\\$androidStudioName\"
      ''');
    logger.i(
      'Finished $androidStudioName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
  }

  if (!userChoice.installAndroidStudio) {
    setCurrentTaskText(
      'Skipping Downloading Android Studio Latest Version for Windows',
    );
    setPercentage(percentage);
    await fakeDelay();
  }
}

/// install `Visual Studio Code` for windows
/// run the `.exe` installer
Future<void> _installVisualStudioCode({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  if (userChoice.installVisualStudioCode) {
    setCurrentTaskText(
      'Downloading Visual Studio Code Latest Version\n(This might take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    AppRelease visualStudioCodeRelease =
        await _apiService.getLatestVisualStudioCodeRelease();
    String visualStudioCodeName = "vs_code_installer_win64.exe";
    logger.i(
      'Started Downloading Visual Studio Code For Windows from \"${visualStudioCodeRelease.downloadLinks.windows}\"',
    );
    await shell.run('''
      curl -o $visualStudioCodeName -L "${visualStudioCodeRelease.downloadLinks.windows}"
      ''');
    logger.i(
      'Finished Downloading Visual Studio Code For Windows from \"${visualStudioCodeRelease.downloadLinks.windows}\"',
    );

    setCurrentTaskText(
      'Running $visualStudioCodeName, Follow the steps there',
    );
    setPercentage(percentage + 0.03);
    await fakeDelay();
    logger.i(
      'Started $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}\\$tempDirName\\$visualStudioCodeName\"
      ''');
    logger.i(
      'Finished $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
  }

  if (!userChoice.installVisualStudioCode) {
    setCurrentTaskText(
      'Skipping Downloading Visual Studio Code Latest Version for macOS',
    );
    setPercentage(percentage);
    await fakeDelay();
  }
}

/// install `IntelliJ IDEA` for windows
/// run the `.exe` installer
Future<void> _installIntelliJIDEA({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  if (userChoice.installIntelliJIDEA) {
    setCurrentTaskText(
      'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    AppRelease intelliJIDEARelease =
        await _apiService.getLatestIntelliJIDEARelease();
    String intelliJIDEAName = _utils
        .getAnythingAfterLastSlash(intelliJIDEARelease.downloadLinks.windows);
    logger.i(
      'Started Downloading IntelliJ IDEA For Windows from \"${intelliJIDEARelease.downloadLinks.windows}\"',
    );
    await shell.run('''
      curl -o $intelliJIDEAName -L "${intelliJIDEARelease.downloadLinks.windows}"
      ''');
    logger.i(
      'Finished Downloading IntelliJ IDEA For Windows from \"${intelliJIDEARelease.downloadLinks.windows}\"',
    );

    setCurrentTaskText(
      'Running $intelliJIDEAName, Follow the steps there',
    );
    setPercentage(percentage + 0.03);
    await fakeDelay();
    logger.i(
      'Started $intelliJIDEAName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}\\$tempDirName\\$intelliJIDEAName\"
      ''');
    logger.i(
      'Finished $intelliJIDEAName from ${await _localStorageService.getTempDiretoryPath()}\\$tempDirName',
    );
  }

  if (!userChoice.installIntelliJIDEA) {
    setCurrentTaskText(
      'Skipping Downloading IntelliJ IDEA Latest Version for Windows',
    );
    setPercentage(percentage);
    await fakeDelay();
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
    'You\'re Done! 🚀😎',
  );
  setPercentage(percentage);
  await fakeDelay();
  logger.i(
    'Finished installing Flutter for Windows!',
  );
}
