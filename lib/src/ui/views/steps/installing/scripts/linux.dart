import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';

final Utils _utils = locator<Utils>();
final LocalStorageService _localStorageService = locator<LocalStorageService>();
final ApiService _apiService = locator<ApiService>();

Future<void> installOnLinux({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On Linux');

  FlutterRelease flutterRelease = await _apiService.getLatestRelease(
    flutterChannel: userChoice.flutterChannel,
    platform: FlutterReleasePlatform.linux,
  );

  final String archiveName =
      _utils.getAnythingAfterLastSlash(flutterRelease.archive);
  logger.i('Archive Name: $archiveName');
  final String tempDirName = 'flutter_installer_${_utils.randomString(5)}';
  logger.i('Temp Directory Name: $tempDirName');

  /// create a `shell`
  setCurrentTaskText('Creating shell');
  setPercentage(0.01);
  await fakeDelay();
  logger.i('Created Shell: ${shell.toString()}');

  /// `cd` into Temp directory
  setCurrentTaskText('Changing directory to "temp"');
  setPercentage(0.05);
  await fakeDelay();
  shell = shell.pushd(await _localStorageService.getTempDiretoryPath());
  logger.i('Change Directory to Temp');

  /// create `flutter_installer` directory
  setCurrentTaskText('Creating "$tempDirName" directory');
  setPercentage(0.10);
  await fakeDelay();
  await shell.run('''
    mkdir $tempDirName
    ''');
  logger.i('Created $tempDirName');

  /// `cd` into `flutter_installer` directory
  setCurrentTaskText('Changing directory to "$tempDirName"');
  setPercentage(0.15);
  await fakeDelay();
  shell = shell.pushd('$tempDirName');
  logger.i('Change directory to $tempDirName');

  /// download `dist.sh` for knowing distro name using `curl`
  setCurrentTaskText(
    'Downloading "dist.sh" for knowing your Linux distro',
  );
  setPercentage(0.17);
  await fakeDelay();
  final String getDistroURL =
      "https://gist.githubusercontent.com/YazeedAlKhalaf/d03c9bda0d2e3815b819d0ebccdac2e6/raw/bf357bcf5f367e9794458aa86687c48c6a596957/dist.sh";
  await shell.run('''
  curl -o dist.sh -L $getDistroURL
  ''');

  /// run `dist.sh` for knowing distor name
  setCurrentTaskText('Getting Linux distro name using "dist.sh"');
  setPercentage(0.20);
  await fakeDelay();
  List<ProcessResult> distroNameList = await shell.run('''
  bash \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/dist.sh\"
  ''');
  final String distroName = distroNameList[0].stdout;
  // final String distroVersion = distroNameList[1].stdout;
  logger.i('Distro Name: $distroName');
  // logger.i('Distro Version: $distroVersion');

  /// download Flutter SDK for Linux using `curl`
  setCurrentTaskText(
    'Downloading Flutter SDK for Linux\n(This may take some time)',
  );
  setPercentage(0.25);
  await fakeDelay();
  logger.i(
    'Started Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
  await shell.run('''
    curl -o $archiveName \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"
    ''');
  logger.i(
    'Finished Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );

  /// use `tar` to unzip the downloaded file
  setCurrentTaskText(
      'Unzipping Flutter SDK to installation path\n(This might take some time)');
  setPercentage(0.3);
  await fakeDelay();
  logger.i(
    'Started Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );
  await shell.run('''
    tar -xf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$archiveName\" -C \"${userChoice.installationPath}\"
    ''');
  logger.i(
    'Finished Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );

  /// download `append-to-path.sh`
  setCurrentTaskText(
    'Downloading Script for adding to PATH',
  );
  setPercentage(0.35);
  final String appendToPathLink =
      "https://gist.githubusercontent.com/YazeedAlKhalaf/2e063e344b3f3f4bb99a79c601e17a13/raw/809b6b119dca8900c306788f0864e7bbcd26c9a2/append-to-path.sh";
  final String appendToPathName = "append-to-path.sh";
  await shell.run('''
  curl -o $appendToPathName -L $appendToPathLink
  ''');

  /// add `flutter` to the `PATH`
  setCurrentTaskText(
    'Adding Flutter SDK to the PATH',
  );
  setPercentage(0.35);
  await fakeDelay();
  String flutterPath = "${userChoice.installationPath}/flutter/bin";
  await shell.run('''
  bash \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$appendToPathName\" $flutterPath
  ''');

  if (userChoice.installGit) {
    /// install `git` for linux
    setCurrentTaskText(
      'Downloading Git for Linux\n(This may take some time)',
    );
    setPercentage(0.4);
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
    setPercentage(0.4);
    await fakeDelay();
  }

  if (userChoice.installAndroidStudio) {
    /// install `Android Studio` for Linux
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(0.45);
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

    /// use `tar` to unzip the downloaded file
    setCurrentTaskText(
        'Unzipping Android Studio Latest Version to installation path\n(This might take some time)');
    setPercentage(0.50);
    await fakeDelay();
    logger.i(
      'Started Extracting of \"$androidStudioName\" from \"${androidStudioRelease.downloadLinks.linux}\"',
    );
    await shell.run('''
    tar -xf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$androidStudioName\" -C \"${userChoice.installationPath}\"
    ''');
    logger.i(
      'Finished Extracting of \"$androidStudioName\" from \"${androidStudioRelease.downloadLinks.linux}\"',
    );

    /// start `Android Studio` using `studio.sh`
    setCurrentTaskText(
      'Running $androidStudioName, Follow the steps there',
    );
    setPercentage(0.55);
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
    setPercentage(0.55);
    await fakeDelay();
  }

  if (userChoice.installIntelliJIDEA) {
    /// install `IntelliJ IDEA` for linux
    setCurrentTaskText(
      'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    );
    setPercentage(0.60);
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

    /// use `tar` to unzip the downloaded file
    setCurrentTaskText(
        'Unzipping IntelliJIDEA Latest Version to installation path\n(This might take some time)');
    setPercentage(0.65);
    await fakeDelay();
    String extractedFolderName = "idea-IC";
    logger.i(
      'Started Extracting of \"$intelliJIDEAName\" from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );
    await shell.run('''
    mkdir ${userChoice.installationPath}/$extractedFolderName
    tar -xf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$intelliJIDEAName\" -C \"${userChoice.installationPath}/$extractedFolderName\" --strip-components=1
    ''');
    logger.i(
      'Finished Extracting of \"$intelliJIDEAName\" from \"${intelliJIDEARelease.downloadLinks.linux}\"',
    );

    /// start `IntelliJIDEA` using `idea.sh`
    setCurrentTaskText(
      'Running $intelliJIDEAName, Follow the steps there',
    );
    setPercentage(0.70);
    await fakeDelay();
    logger.i(
      'Started IntelliJIDEA Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
    await shell.run('''
      bash \"${userChoice.installationPath}/$extractedFolderName/bin/idea.sh\"
      ''');
    logger.i(
      'Finished IntelliJIDEA Latest Version from ${userChoice.installationPath}/$extractedFolderName',
    );
  }

  if (!userChoice.installIntelliJIDEA) {
    setCurrentTaskText(
      'Skipping Downloading IntelliJ IDEA Latest Version for Linux',
    );
    setPercentage(0.70);
    await fakeDelay();
  }

  if (userChoice.installVisualStudioCode) {
    /// install `Visual Studio Code` for Linux
    setCurrentTaskText(
      'Downloading Visual Studio Code Latest Version\n(This might take some time)',
    );
    setPercentage(0.75);
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

    /// use `tar` to unzip the downloaded file
    setCurrentTaskText(
        'Unzipping Visual Studio Code Latest Version to installation path\n(This might take some time)');
    setPercentage(0.80);
    await fakeDelay();
    String extractedFolderName = "vs-code-x64-linux";
    logger.i(
      'Started Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
    );
    await shell.run('''
    mkdir ${userChoice.installationPath}/$extractedFolderName
    tar -xf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$visualStudioCodeName\" -C \"${userChoice.installationPath}/$extractedFolderName\" --strip-components=1
    ''');
    logger.i(
      'Finished Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
    );

    /// start `Visual Studio Code` using `code`
    setCurrentTaskText(
      'Running $visualStudioCodeName, Follow the steps there',
    );
    setPercentage(0.85);
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
    setPercentage(0.85);
    await fakeDelay();
  }

  /// Clean Up
  setCurrentTaskText(
    'Cleaning Up!',
  );
  setPercentage(0.9);
  await fakeDelay();
  logger.i(
    'Finished Cleaning Up!',
  );

  /// Done 🚀😎
  setCurrentTaskText(
    'You\'re Done! 🚀😎',
  );
  setPercentage(1.0);
  await fakeDelay();
  logger.i(
    'Finished installing Flutter for Linux!',
  );
}
