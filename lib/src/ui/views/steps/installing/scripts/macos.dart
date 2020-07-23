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

Future<void> installOnMacOS({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On macOS');

  FlutterRelease flutterRelease = await _apiService.getLatestRelease(
    flutterChannel: userChoice.flutterChannel,
    platform: FlutterReleasePlatform.macOS,
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

  // /// download Flutter SDK for macOS using `curl`
  // setCurrentTaskText(
  //   'Downloading Flutter SDK for macOS\n(This may take some time)',
  // );
  // setPercentage(0.25);
  // await fakeDelay();
  // logger.i(
  //   'Started Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  // );
  // await shell.run('''
  //   curl -o $archiveName \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"
  //   ''');
  // logger.i(
  //   'Finished Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  // );

  // /// use `tar` to unzip the downloaded file
  // setCurrentTaskText(
  //     'Unzipping Flutter SDK to installation path\n(This might take some time)');
  // setPercentage(0.3);
  // await fakeDelay();
  // logger.i(
  //   'Started Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  // );
  // await shell.run('''
  //   tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$archiveName\" -C \"${userChoice.installationPath}\"
  //   ''');
  // logger.i(
  //   'Finished Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  // );

  /// download `append-to-path-zsh.sh`
  setCurrentTaskText(
    'Downloading Script for adding to PATH',
  );
  setPercentage(0.35);
  final String appendToPathLink =
      "https://gist.githubusercontent.com/YazeedAlKhalaf/2e063e344b3f3f4bb99a79c601e17a13/raw/208936d814d2e755962f6a57f0dd1b02a8ef891e/append-to-path-zsh.sh";
  final String appendToPathName = "append-to-path-zsh.sh";
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
  sudo /bin/bash \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$appendToPathName\" $flutterPath
  ''');

  if (userChoice.installGit) {
    /// install `git` for macOS
    setCurrentTaskText(
      'Downloading Git for macOS\n(This may take some time)',
    );
    setPercentage(0.4);
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

  if (!userChoice.installGit) {
    setCurrentTaskText(
      'Skipping Downloading Git for macOS',
    );
    setPercentage(0.4);
    await fakeDelay();
  }

  if (userChoice.installAndroidStudio) {
    /// install `Android Studio` for macOS
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(0.45);
    await fakeDelay();
    AppRelease androidStudioRelease =
        await _apiService.getLatestAndroidStudioRelease();
    String androidStudioName = _utils
        .getAnythingAfterLastSlash(androidStudioRelease.downloadLinks.macos);
    String androidStudioDownloadLink = androidStudioRelease.downloadLinks.macos;
    logger.i(
      'Started Downloading Android Studio For macOS',
    );
    await shell.run('''
      curl -o $androidStudioName -L "$androidStudioDownloadLink"
      ''');
    logger.i(
      'Finished Downloading Android Studio For macOS',
    );

    /// start `Android Studio`
    setCurrentTaskText(
      'Running $androidStudioName, Follow the steps there\nIf nothing showed up, open finder and you\'ll find it mounted',
    );
    setPercentage(0.55);
    await fakeDelay();
    logger.i(
      'Started Android Studio Latest Version',
    );
    await shell.run('''
    open \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$androidStudioName\"
    ''');
    logger.i(
      'Finished Android Studio Latest Version',
    );
  }

  if (!userChoice.installAndroidStudio) {
    setCurrentTaskText(
      'Skipping Downloading Android Studio Latest Version for macOS',
    );
    setPercentage(0.55);
    await fakeDelay();
  }

  if (userChoice.installIntelliJIDEA) {
    /// install `IntelliJ IDEA` for macOS
    setCurrentTaskText(
      'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    );
    setPercentage(0.60);
    await fakeDelay();
    AppRelease intelliJIDEARelease =
        await _apiService.getLatestIntelliJIDEARelease();
    String intelliJIDEAName = _utils
        .getAnythingAfterLastSlash(intelliJIDEARelease.downloadLinks.macos);
    String intelliJIDEADownloadLink = intelliJIDEARelease.downloadLinks.macos;
    logger.i(
      'Started Downloading IntelliJ IDEA For macOS from \"$intelliJIDEADownloadLink\"',
    );
    await shell.run('''
      curl -o $intelliJIDEAName -L "$intelliJIDEADownloadLink"
      ''');
    logger.i(
      'Finished Downloading IntelliJ IDEA For macOS from \"$intelliJIDEADownloadLink\"',
    );

    /// start `IntelliJIDEA`
    setCurrentTaskText(
      'Running $intelliJIDEAName, Follow the steps there\nIf nothing showed up, open finder and you\'ll find it mounted',
    );
    setPercentage(0.70);
    await fakeDelay();
    logger.i(
      'Started IntelliJIDEA Latest Version',
    );
    await shell.run('''
    open \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$intelliJIDEAName\"
    ''');
    logger.i(
      'Finished IntelliJIDEA Latest Version',
    );
  }

  if (!userChoice.installIntelliJIDEA) {
    setCurrentTaskText(
      'Skipping Downloading IntelliJ IDEA Latest Version for macOS',
    );
    setPercentage(0.70);
    await fakeDelay();
  }

  // if (userChoice.installVisualStudioCode) {
  //   /// install `Visual Studio Code` for macOS
  //   setCurrentTaskText(
  //     'Downloading Visual Studio Code Latest Version\n(This might take some time)',
  //   );
  //   setPercentage(0.75);
  //   await fakeDelay();
  //   AppRelease visualStudioCodeRelease =
  //       await _apiService.getLatestVisualStudioCodeRelease();
  //   String visualStudioCodeDownloadLink =
  //       visualStudioCodeRelease.downloadLinks.macos;
  //   String visualStudioCodeName = "code-stable-darwin.zip";
  //   logger.i(
  //     'Started Downloading Visual Studio Code For macOS from \"$visualStudioCodeDownloadLink\"',
  //   );
  //   await shell.run('''
  //     curl -o $visualStudioCodeName -L "$visualStudioCodeDownloadLink"
  //     ''');
  //   logger.i(
  //     'Finished Downloading Visual Studio Code For macOS from \"$visualStudioCodeDownloadLink\"',
  //   );

  //   /// use `tar` to unzip the downloaded file
  //   setCurrentTaskText(
  //       'Unzipping Visual Studio Code Latest Version to installation path\n(This might take some time)');
  //   setPercentage(0.80);
  //   await fakeDelay();
  //   logger.i(
  //     'Started Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
  //   );
  //   await shell.run('''
  //   tar -xvf \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$visualStudioCodeName\"
  //   ''');
  //   logger.i(
  //     'Finished Extracting of \"$visualStudioCodeName\" from \"$visualStudioCodeDownloadLink\"',
  //   );

  //   /// move `Visual Studio Code.app` to applications
  //   setCurrentTaskText(
  //     'Moving Visual Studio Code.app to Applications',
  //   );
  //   setPercentage(0.85);
  //   await fakeDelay();
  //   final String vscodeappName = "Visual Studio Code.app";
  //   logger.i(
  //     'Started Moving Visual Studio Code Latest Version',
  //   );
  //   await shell.run('''
  //   sudo cp -R \"${await _localStorageService.getTempDiretoryPath()}/$tempDirName/$vscodeappName\" \"/Applications\"
  //   ''');
  //   logger.i(
  //     'Finished Moving Visual Studio Code Latest Version',
  //   );
  // }

  if (!userChoice.installVisualStudioCode) {
    setCurrentTaskText(
      'Skipping Downloading Visual Studio Code Latest Version for macOS',
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
    'Finished installing Flutter for macOS!',
  );
}
