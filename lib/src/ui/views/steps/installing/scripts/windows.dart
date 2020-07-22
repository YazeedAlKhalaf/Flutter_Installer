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

Future<void> installOnWindows({
  @required Logger logger,
  @required UserChoice userChoice,
  @required Shell shell,
  @required Function(String taskText) setCurrentTaskText,
  @required Function(double newPercentage) setPercentage,
  @required Future<void> Function({int seconds}) fakeDelay,
}) async {
  logger.i('Install On Windows');

  FlutterRelease flutterRelease = await _apiService.getLatestRelease(
    flutterChannel: userChoice.flutterChannel,
    platform: FlutterReleasePlatform.windows,
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
    C:\\Windows\\System32\\tar.exe -xf \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$archiveName\" -C \"${userChoice.installationPath}\"
    ''');
  logger.i(
    'Finished Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
  );

  /// download `.bat` file for adding `flutter` to `PATH`
  setCurrentTaskText(
    'Downloading Script for adding Flutter SDK to PATH',
  );
  setPercentage(0.325);
  await fakeDelay();
  String appendToPathScriptLink =
      "https://gist.githubusercontent.com/YazeedAlKhalaf/fae357096390f54a768f091a35efea7f/raw/eef15570660402d3757a3b39acfc0693d8c60b3c/append-to-path.bat";
  String appendToPathScriptName = "append-to-path.bat";
  logger.i(
    'Started Downloading of \"$appendToPathScriptName\" from \"$appendToPathScriptLink\"',
  );
  await shell.run("""
    curl -o $appendToPathScriptName -L \"$appendToPathScriptLink\"
    """);
  logger.i(
    'Finished Downloading of \"$appendToPathScriptName\" from \"$appendToPathScriptLink\"',
  );

  /// add `flutter` to the `PATH`
  setCurrentTaskText(
    'Adding Flutter SDK to the PATH',
  );
  setPercentage(0.35);
  await fakeDelay();
  String flutterPath = "${userChoice.installationPath}\\flutter\\bin";
  await shell.run("""
    $appendToPathScriptName \"$flutterPath\"
    """);

  if (userChoice.installGit) {
    /// install `git` for windows
    setCurrentTaskText(
      'Downloading Git for Windows\n(This may take some time)',
    );
    setPercentage(0.4);
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

    /// run the `.exe` installer
    setCurrentTaskText(
      'Running $gitDownloadName, Follow the steps there',
    );
    setPercentage(0.45);
    await fakeDelay();
    logger.i(
      'Started $gitDownloadName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
    await shell.run('''
      start "${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$gitDownloadName"
      ''');
    logger.i(
      'Finished $gitDownloadName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
  }

  if (userChoice.installAndroidStudio) {
    /// install `Android Studio` for windows
    setCurrentTaskText(
      'Downloading Android Studio Latest Version\n(This might take some time)',
    );
    setPercentage(0.475);
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

    /// run the `.exe` installer
    setCurrentTaskText(
      'Running $androidStudioName, Follow the steps there',
    );
    setPercentage(0.5);
    await fakeDelay();
    logger.i(
      'Started $androidStudioName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$androidStudioName\"
      ''');
    logger.i(
      'Finished $androidStudioName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
  }

  if (userChoice.installVisualStudioCode) {
    /// install `Visual Studio Code` for windows
    setCurrentTaskText(
      'Downloading Visual Studio Code Latest Version\n(This might take some time)',
    );
    setPercentage(0.525);
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

    /// run the `.exe` installer
    setCurrentTaskText(
      'Running $visualStudioCodeName, Follow the steps there',
    );
    setPercentage(0.55);
    await fakeDelay();
    logger.i(
      'Started $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$visualStudioCodeName\"
      ''');
    logger.i(
      'Finished $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
  }

  if (userChoice.installIntelliJIDEA) {
    /// install `IntelliJ IDEA` for windows
    setCurrentTaskText(
      'Downloading IntelliJ IDEA Latest Version\n(This might take some time)',
    );
    setPercentage(0.575);
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

    /// run the `.exe` installer
    setCurrentTaskText(
      'Running $intelliJIDEAName, Follow the steps there',
    );
    setPercentage(0.6);
    await fakeDelay();
    logger.i(
      'Started $intelliJIDEAName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
    await shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$intelliJIDEAName\"
      ''');
    logger.i(
      'Finished $intelliJIDEAName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
    );
  }

  /// Done 🚀😎
  setCurrentTaskText(
    'You\'re Done! 🚀😎',
  );
  setPercentage(1.0);
  await fakeDelay();
  logger.i(
    'Finished installing Flutter for Windows!',
  );
}
