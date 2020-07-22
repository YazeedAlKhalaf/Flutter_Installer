import 'package:flutter/foundation.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
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
  setPercentage(0.05);
  await fakeDelay();
  logger.i('Created Shell: ${shell.toString()}');

  /// `cd` into Temp directory
  setCurrentTaskText('Changing directory to "temp"');
  setPercentage(0.1);
  await fakeDelay();
  shell = shell.pushd(await _localStorageService.getTempDiretoryPath());
  logger.i('Change Directory to Temp');

  /// create `flutter_installer` directory
  setCurrentTaskText('Creating "$tempDirName" directory');
  setPercentage(0.15);
  await fakeDelay();
  await shell.run('''
    mkdir $tempDirName
    ''');
  logger.i('Created $tempDirName');

  /// `cd` into `flutter_installer` directory
  setCurrentTaskText('Changing directory to "$tempDirName"');
  setPercentage(0.2);
  await fakeDelay();
  shell = shell.pushd('$tempDirName');
  logger.i('Change directory to $tempDirName');

  /// download Flutter SDK for Windows using `curl`
  setCurrentTaskText(
    'Downloading Flutter SDK for Windows\n(This may take some time)',
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

  /// add `flutter` to the `PATH`
  // TODO(yazeed): Add Flutter To PATH command
  setCurrentTaskText(
    'Adding Flutter SDK to the PATH',
  );
  setPercentage(0.35);
  await fakeDelay();

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
    await shell.run('''
      sudo apt install git-all -y
    ''');
    logger.i(
      'Finished Downloading Git For Linux',
    );
  }

  if (userChoice.installAndroidStudio) {
    /// install `Android Studio` for Linux
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(0.475);
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
    setPercentage(0.5);
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
    setPercentage(0.6);
    await fakeDelay();
    logger.i(
      'Started Android Studio Latest Version from ${userChoice.installationPath}/android-studio',
    );
    await shell.run('''
      bash \"${userChoice.installationPath}/android-studio/bin/studio.sh\"
      ''');
    logger.i(
      'Finished Android Studio Latest Version from ${userChoice.installationPath}/android-studio',
    );
  }
}
