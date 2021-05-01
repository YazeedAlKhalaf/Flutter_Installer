import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
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
String distroName;

String appendToPathScriptName = "append-to-path.sh";

Future<void> installOnLinux({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On Linux');

  Shell myShell = shell;

  const double percentageMultiple = 0.005882353;

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

  await _downloadDistDotSh(
    percentage: percentageMultiple * 6,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  distroName = await _runDistDotSh(
    percentage: percentageMultiple * 7,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _downloadFlutterSdkForLinuxWithCurl(
    percentage: percentageMultiple * 8,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _upzipDownloadedFlutterSdkForLinux(
    percentage: percentageMultiple * 9,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _downloadScriptForAddingFlutterToPath(
    percentage: percentageMultiple * 10,
    logger: logger,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _runAddFlutterToPathScript(
    percentage: percentageMultiple * 11,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _installGit(
    percentage: percentageMultiple * 12,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installAndroidStudio(
    percentage: percentageMultiple * 13,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installIntelliJIDEA(
    percentage: percentageMultiple * 14,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );
  await _installVisualStudioCode(
    percentage: percentageMultiple * 15,
    logger: logger,
    userChoice: userChoice,
    shell: myShell,
    setCurrentTaskText: setCurrentTaskText,
    setPercentage: setPercentage,
    fakeDelay: fakeDelay,
  );

  await _cleanup(
    percentage: percentageMultiple * 16,
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
    platform: FlutterReleasePlatform.linux,
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

/// download `dist.sh` for knowing distro name using `curl`
Future<void> _downloadDistDotSh({
  @required double percentage,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading "dist.sh" for knowing your Linux distro',
  );
  setPercentage(percentage);
  await fakeDelay();
  ScriptRelease distScriptRelease = await _apiService.getLatestDistScript();
  String distScriptLink = distScriptRelease.downloadLinks.linux;
  await shell.run("""
  curl -o dist.sh -L $distScriptLink
  """);
}

/// run `dist.sh` for knowing distor name
Future<String> _runDistDotSh({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText('Getting Linux distro name using "dist.sh"');
  setPercentage(percentage);
  await fakeDelay();
  List<ProcessResult> distroNameList = await shell.run('''
  bash \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/dist.sh\"
  ''');
  final String distroName = distroNameList[0].stdout;
  logger.i('Distro Name: $distroName');
  return distroName;
}

/// download Flutter SDK for Linux using `curl`
Future<void> _downloadFlutterSdkForLinuxWithCurl({
  @required double percentage,
  @required Logger logger,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    'Downloading Flutter SDK for Linux\n(This may take some time)',
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
Future<void> _upzipDownloadedFlutterSdkForLinux({
  @required double percentage,
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  setCurrentTaskText(
    "Unzipping Flutter SDK to installation path\n(This might take some time)",
  );
  setPercentage(percentage);

  /// wait for file to be installed fully
  /// sometimes it breaks of you don't wait
  await fakeDelay(seconds: 6);
  logger.i(
    "Started Extracting of $archiveName from ${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}",
  );
  await shell.run("""
    tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$archiveName\" -C \"${userChoice.installationPath}\"
    """);
  logger.i(
    "Finished Extracting of $archiveName from ${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}",
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
  ScriptRelease appendToPathScriptRelease =
      await _apiService.getLatestAppendToPathScript();
  String appendToPathScriptLink = appendToPathScriptRelease.downloadLinks.linux;
  logger.i(
    "Started Downloading of $appendToPathScriptName from $appendToPathScriptLink",
  );
  await shell.run("""
  curl -o $appendToPathScriptName -L $appendToPathScriptLink
  """);
  logger.i(
    "Finished Downloading of $appendToPathScriptName from $appendToPathScriptLink",
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
    "Adding Flutter SDK to the PATH",
  );
  setPercentage(percentage);
  await fakeDelay();
  String flutterPath = "${userChoice.installationPath}/flutter/bin";
  await shell.run("""
  bash \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$appendToPathScriptName\" $flutterPath
  """);
  logger.i(
    "Added Flutter to PATH",
  );
}

/// install `git` for linux
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
      'Downloading Git for Linux\n(This may take some time)',
    );
    setPercentage(percentage);
    await fakeDelay();
    logger.i(
      'Started Downloading Git For Linux',
    );
    switch (distroName) {
      case "ubuntu":
      case "debian":
        await shell.run('''
        sudo apt install git -y
        ''');
        break;
      case "archlinux":
        await shell.run('''
        sudo pacman -S git -y
        ''');
        break;
      case "opensuse":
        await shell.run('''
        sudo zypper install git -y
        ''');
        break;
      case "OpenBSD":
        await shell.run('''
        sudo pkg_add git -y
        ''');
        break;
      case "NetBSD":
      case "FreeBSD":
        await shell.run('''
        sudo pkg install git -y
        ''');
        break;
      case "solaris":
        await shell.run('''
        sudo pkgutil -i git -y
        ''');
        break;
      // default:
    }
    logger.i(
      'Finished Downloading Git For Linux',
    );
  }

  if (!userChoice.installGit) {
    setCurrentTaskText(
      'Skipping Downloading Git for Linux',
    );
    setPercentage(percentage);
    await fakeDelay();
  }
}

/// install `Android Studio` for Linux
/// use `tar` to unzip the downloaded file
/// start `Android Studio` using `studio.sh`
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
        .getAnythingAfterLastSlash(androidStudioRelease.downloadLinks.linux);
    logger.i(
      'Started Downloading Android Studio For Linux from \"${androidStudioRelease.downloadLinks.linux}\"',
    );
    await shell.run('''
      curl -o $androidStudioName -L "${androidStudioRelease.downloadLinks.linux}"
      ''');
    logger.i(
      'Finished Downloading Android Studio For Linux from \"${androidStudioRelease.downloadLinks.linux}\"',
    );

    setCurrentTaskText(
        'Unzipping Android Studio Latest Version to installation path\n(This might take some time)');
    setPercentage(percentage + 0.01);
    await fakeDelay();
    logger.i(
      'Started Extracting of \"$androidStudioName\" from \"${androidStudioRelease.downloadLinks.linux}\"',
    );
    await shell.run('''
    tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$androidStudioName\" -C \"${userChoice.installationPath}\"
    ''');
    logger.i(
      'Finished Extracting of \"$androidStudioName\" from \"${androidStudioRelease.downloadLinks.linux}\"',
    );

    setCurrentTaskText(
      'Running $androidStudioName, Follow the steps there',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
    String extractedFolderName = "android-studio";
    logger.i(
      'Started Android Studio Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
    await shell.run('''
      bash \"${userChoice.installationPath}/$extractedFolderName/bin/studio.sh\"
      ''');
    logger.i(
      'Finished Android Studio Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
  }

  if (!userChoice.installAndroidStudio) {
    setCurrentTaskText(
      'Skipping Downloading Android Studio Latest Version for Linux',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
  }
}

/// install `IntelliJ IDEA` for linux
/// use `tar` to unzip the downloaded file
/// start `IntelliJIDEA` using `idea.sh`
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
        .getAnythingAfterLastSlash(intelliJIDEARelease.downloadLinks.linux);
    logger.i(
      'Started Downloading IntelliJ IDEA For Linux from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );
    await shell.run('''
      curl -o $intelliJIDEAName -L "${intelliJIDEARelease.downloadLinks.linux}"
      ''');
    logger.i(
      'Finished Downloading IntelliJ IDEA For Linux from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );

    setCurrentTaskText(
        'Unzipping IntelliJIDEA Latest Version to installation path\n(This might take some time)');
    setPercentage(percentage + 0.01);
    await fakeDelay();
    String extractedFolderName = "idea-IC";
    logger.i(
      'Started Extracting of \"$intelliJIDEAName\" from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );
    await shell.run('''
    mkdir ${userChoice.installationPath}/$extractedFolderName
    tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$intelliJIDEAName\" -C \"${userChoice.installationPath}/$extractedFolderName\" --strip-components=1
    ''');
    logger.i(
      'Finished Extracting of \"$intelliJIDEAName\" from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );

    setCurrentTaskText(
      'Running $intelliJIDEAName, Follow the steps there',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
    logger.i(
      "Started IntelliJIDEA Latest Version from ${userChoice.installationPath}/$extractedFolderName",
    );
    await shell.run("""
      bash \"${userChoice.installationPath}/$extractedFolderName/bin/idea.sh\"
      """);
    logger.i(
      "Finished IntelliJIDEA Latest Version from ${userChoice.installationPath}/$extractedFolderName",
    );
  }

  if (!userChoice.installIntelliJIDEA) {
    setCurrentTaskText(
      'Skipping Downloading IntelliJ IDEA Latest Version for Linux',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
  }
}

/// install `Visual Studio Code` for Linux
/// use `tar` to unzip the downloaded file
/// start `Visual Studio Code` using `code`
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
    String visualStudioCodeDownloadLink =
        visualStudioCodeRelease.downloadLinks.linux;
    String visualStudioCodeName = "code-stable.tar.gz";
    logger.i(
      'Started Downloading Visual Studio Code For Linux from \"$visualStudioCodeDownloadLink\"',
    );
    await shell.run('''
      curl -o $visualStudioCodeName -L "$visualStudioCodeDownloadLink"
      ''');
    logger.i(
      'Finished Downloading Visual Studio Code For Linux from \"$visualStudioCodeDownloadLink\"',
    );

    setCurrentTaskText(
        'Unzipping Visual Studio Code Latest Version to installation path\n(This might take some time)');
    setPercentage(percentage + 0.01);
    await fakeDelay();
    String extractedFolderName = "vs-code-x64-linux";
    logger.i(
      'Started Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
    );
    await shell.run('''
    mkdir ${userChoice.installationPath}/$extractedFolderName
    tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$visualStudioCodeName\" -C \"${userChoice.installationPath}/$extractedFolderName\" --strip-components=1
    ''');
    logger.i(
      'Finished Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
    );

    setCurrentTaskText(
      'Running $visualStudioCodeName, Follow the steps there',
    );
    setPercentage(percentage + 0.02);
    await fakeDelay();
    logger.i(
      'Started Visual Studio Code Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
    await shell.run('''
      bash \"${userChoice.installationPath}/$extractedFolderName/bin/code\"
      ''');
    logger.i(
      'Finished Visual Studio Code Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
  }

  if (!userChoice.installVisualStudioCode) {
    setCurrentTaskText(
      'Skipping Downloading Visual Studio Code Latest Version for Linux',
    );
    setPercentage(percentage + 0.02);
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
