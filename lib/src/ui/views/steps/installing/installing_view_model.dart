import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class Line {
  final String text;

  Line(this.text);
}

class ErrLine extends Line {
  ErrLine(String text) : super(text);
}

class OutLine extends Line {
  OutLine(String text) : super(text);
}

class InstallingViewModel extends CustomBaseViewModel {
  Shell _shell;
  final _stdoutCtlr = StreamController<List<int>>();
  final _stderrCtlr = StreamController<List<int>>();
  final linesCtlr = StreamController<List<Line>>();
  List<Line> _lines = <Line>[];
  List<Line> get lines => _lines;

  final ScrollController scrollController = ScrollController();

  bool _showLog = false;
  bool get showLog => _showLog;
  void setShowLog(bool newValue) {
    _showLog = newValue;
    notifyListeners();
  }

  void _addLine(Line line) {
    _lines.add(line);
    // Limit line count
    if (_lines.length > 100) {
      _lines = _lines.sublist(20);
    }
    linesCtlr.add(_lines);
  }

  @override
  void dispose() {
    super.dispose();
    _stdoutCtlr.close();
    _stderrCtlr.close();
    linesCtlr.close();
  }

  final Logger logger = getLogger('InstallingViewModel');

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
    logger.v(_currentTaskText);
    notifyListeners();
  }

  Future<void> initialize({
    @required UserChoice userChoice,
  }) async {
    utf8.decoder
        .bind(_stdoutCtlr.stream)
        .transform(const LineSplitter())
        .listen((text) {
      _addLine(OutLine(text));
    });
    utf8.decoder
        .bind(_stderrCtlr.stream)
        .transform(const LineSplitter())
        .listen((text) {
      _addLine(ErrLine(text));
    });
    _shell = Shell(stdout: _stdoutCtlr.sink, stderr: _stderrCtlr.sink);
    _addLine(OutLine('Here is the log of the Flutter installer'));
    _addLine(ErrLine('Error text will be displayed in red'));

    setPercentage(0.0);
    setCurrentTaskText('Preparing...');
    getVariables(
      userChoice: userChoice,
    );
    logger.v('Install Function started');
    await fakeDelay();
    await install();
    logger.v('Install Function ended');
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

    if (dialogResponse.confirmed) {
      logger.i('Installation Cancelled!');
    }

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
    setPercentage(0.1);
    await fakeDelay();
    logger.i('Created Shell: ${_shell.toString()}');

    /// `cd` into Temp directory
    setCurrentTaskText('Changing directory to "temp"');
    setPercentage(0.2);
    await fakeDelay();
    _shell = _shell.pushd(await _localStorageService.getTempDiretoryPath());
    logger.i('Change Directory to Temp');

    /// create `flutter_installer` directory
    setCurrentTaskText('Creating "$tempDirName" directory');
    setPercentage(0.3);
    await fakeDelay();
    await _shell.run('''
    mkdir $tempDirName
    ''');
    logger.i('Created $tempDirName');

    /// `cd` into `flutter_installer` directory
    setCurrentTaskText('Changing directory to "$tempDirName"');
    setPercentage(0.4);
    await fakeDelay();
    _shell = _shell.pushd('$tempDirName');
    logger.i('Change directory to $tempDirName');

    /// download Flutter SDK for Windows using `curl`
    setCurrentTaskText(
      'Downloading Flutter SDK for Windows\n(This may take some time)',
    );
    setPercentage(0.5);
    await fakeDelay();
    logger.i(
      'Started Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
    );
    await _shell.run('''
    curl -o $archiveName \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"
    ''');
    logger.i(
      'Finished Download of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
    );

    /// use `tar` to unzip the downloaded file
    setCurrentTaskText(
        'Unzipping Flutter SDK to installation path\n(This might take some time)');
    setPercentage(0.6);
    await fakeDelay();
    logger.i(
      'Started Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
    );
    await _shell.run('''
    C:\\Windows\\System32\\tar.exe -xf \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$archiveName\" -C \"${userChoice.installationPath}\"
    ''');
    logger.i(
      'Finished Extracting of \"$archiveName\" from \"${_apiService.baseUrlForFlutterRelease}/${flutterRelease.archive}\"',
    );

    /// add `flutter` to the `PATH`
    setCurrentTaskText(
      'Adding Flutter SDK to the PATH',
    );
    setPercentage(0.7);
    await fakeDelay();
    // TODO(yazeed): Add Flutter to PATH

    if (_userChoice.installGit) {
      /// install `git` for windows
      setCurrentTaskText(
        'Downloading Git for Windows\n(This may take some time)',
      );
      setPercentage(0.8);
      await fakeDelay();
      GithubReleaseAsset githubReleaseAsset =
          await _apiService.getLatestGitForWindowsRelease();
      String gitDownloadName = _utils
          .getAnythingAfterLastSlash(githubReleaseAsset.browserDownloadUrl);
      logger.i(
        'Started Downloading Git For Windows from \"${githubReleaseAsset.browserDownloadUrl}\"',
      );
      await _shell.run('''
      curl -o $gitDownloadName -L "${githubReleaseAsset.browserDownloadUrl}"
      ''');
      logger.i(
        'Finished Downloading Git For Windows from \"${githubReleaseAsset.browserDownloadUrl}\"',
      );

      /// run the `.exe` installer
      setCurrentTaskText(
        'Running $gitDownloadName, Follow the steps there',
      );
      setPercentage(0.9);
      await fakeDelay();
      logger.i(
        'Started $gitDownloadName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
      );
      await _shell.run('''
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
      setPercentage(0.95);
      await fakeDelay();
      AppRelease androidStudioRelease =
          await _apiService.getLatestAndroidStudioRelease();
      String androidStudioName = _utils.getAnythingAfterLastSlash(
          androidStudioRelease.downloadLinks.windows);
      logger.i(
        'Started Downloading Android Studio For Windows from \"${androidStudioRelease.downloadLinks.windows}\"',
      );
      await _shell.run('''
      curl -o $androidStudioName -L "${androidStudioRelease.downloadLinks.windows}"
      ''');
      logger.i(
        'Finished Downloading Android Studio For Windows from \"${androidStudioRelease.downloadLinks.windows}\"',
      );

      /// run the `.exe` installer
      setCurrentTaskText(
        'Running $androidStudioName, Follow the steps there',
      );
      setPercentage(0.9);
      await fakeDelay();
      logger.i(
        'Started $androidStudioName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
      );
      await _shell.run('''
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
      setPercentage(0.95);
      await fakeDelay();
      AppRelease visualStudioCodeRelease =
          await _apiService.getLatestVisualStudioCodeRelease();
      String visualStudioCodeName = _utils.getAnythingAfterLastSlash(
          visualStudioCodeRelease.downloadLinks.windows);
      logger.i(
        'Started Downloading Visual Studio Code For Windows from \"${visualStudioCodeRelease.downloadLinks.windows}\"',
      );
      await _shell.run('''
      curl -o $visualStudioCodeName -L "${visualStudioCodeRelease.downloadLinks.windows}"
      ''');
      logger.i(
        'Finished Downloading Visual Studio Code For Windows from \"${visualStudioCodeRelease.downloadLinks.windows}\"',
      );

      /// run the `.exe` installer
      setCurrentTaskText(
        'Running $visualStudioCodeName, Follow the steps there',
      );
      setPercentage(0.9);
      await fakeDelay();
      logger.i(
        'Started $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
      );
      await _shell.run('''
      start \"${await _localStorageService.getTempDiretoryPath()}$tempDirName\\$visualStudioCodeName\"
      ''');
      logger.i(
        'Finished $visualStudioCodeName from ${await _localStorageService.getTempDiretoryPath()}$tempDirName',
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
