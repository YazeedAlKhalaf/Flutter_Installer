import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/scripts/linux.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/scripts/macos.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/scripts/windows.dart';
import 'package:logger/logger.dart';
import 'package:process_run/shell.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class Line {
  Line(this.text);
  final String text;
}

class ErrLine extends Line {
  ErrLine(String text) : super(text);
}

class OutLine extends Line {
  OutLine(String text) : super(text);
}

class InstallingViewModel extends CustomBaseViewModel {
  Shell _shell;
  final StreamController<List<int>> _stdoutCtlr = StreamController<List<int>>();
  final StreamController<List<int>> _stderrCtlr = StreamController<List<int>>();
  final StreamController<List<Line>> linesCtlr = StreamController<List<Line>>();
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
    if (!linesCtlr.isClosed) {
      linesCtlr.add(_lines);
    }
  }

  @override
  void dispose() {
    _stdoutCtlr?.close();
    _stderrCtlr?.close();
    linesCtlr?.close();
    return super.dispose();
  }

  final Logger logger = getLogger('InstallingViewModel');

  final DialogService _dialogService = locator<DialogService>();

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
    intializeStreamOfShellLines();
    _addLine(OutLine('This is the virtual console :)'));

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

  dynamic getVariables({
    @required UserChoice userChoice,
  }) {
    _userChoice = userChoice;
  }

  Future<bool> showCancelConfirmationDialog() async {
    final DialogResponse dialogResponse =
        await _dialogService.showConfirmationDialog(
      title: 'Are You Sure? 😢',
      description: 'Are You Sure You Wanna Cancel This Download? 😢',
      cancelTitle: 'No, Thanks God 🙏',
      confirmationTitle: '''
Yes, I'm Pretty Sure 🚀''',
      dialogPlatform: DialogPlatform.Material,
    );

    if (dialogResponse.confirmed) {
      logger.i('Installation Cancelled!');
    }

    return dialogResponse.confirmed;
  }

  Future<void> install() async {
    if (Platform.isWindows) {
      await installOnWindows(
        logger: logger,
        userChoice: userChoice,
        shell: _shell,
        setCurrentTaskText: setCurrentTaskText,
        setPercentage: setPercentage,
        fakeDelay: fakeDelay,
      );
    }

    if (Platform.isMacOS) {
      await installOnMacOS(
        logger: logger,
        userChoice: userChoice,
        shell: _shell,
        setCurrentTaskText: setCurrentTaskText,
        setPercentage: setPercentage,
        fakeDelay: fakeDelay,
      );
    }

    if (Platform.isLinux) {
      await installOnLinux(
        logger: logger,
        userChoice: userChoice,
        shell: _shell,
        setCurrentTaskText: setCurrentTaskText,
        setPercentage: setPercentage,
        fakeDelay: fakeDelay,
      );
    }
  }

  void intializeStreamOfShellLines() {
    utf8.decoder
        .bind(_stdoutCtlr.stream)
        .transform(const LineSplitter())
        .listen((String text) {
      _addLine(OutLine(text));
    });
    utf8.decoder
        .bind(_stderrCtlr.stream)
        .transform(const LineSplitter())
        .listen((String text) {
      _addLine(ErrLine(text));
    });
    _shell = Shell(
      stdout: _stdoutCtlr.sink,
      stderr: _stderrCtlr.sink,
    );
  }
}
