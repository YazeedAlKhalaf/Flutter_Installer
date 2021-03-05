import 'dart:io';

import 'package:file_selector/file_selector.dart' as file_selector;
import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomizeViewModel extends CustomBaseViewModel {
  final SnackbarService _snackbarService = SnackbarService();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final TextEditingController chooseFolderController = TextEditingController();

  bool _showAdvanced = false;
  bool get showAdvanced => _showAdvanced;
  void setShowAdvanced(bool newValue) {
    _showAdvanced = newValue;
    notifyListeners();
  }

  bool _chooseFolderTextFieldHasError = false;
  bool get chooseFolderTextFieldHasError => _chooseFolderTextFieldHasError;
  void setChooseFolderTextFieldHasError(bool newValue) {
    _chooseFolderTextFieldHasError = newValue;
    notifyListeners();
  }

  String _installationPath;
  String get installationPath => _installationPath;
  void setInstallationPath(String newValue) {
    _installationPath = newValue;
    notifyListeners();
  }

  bool _installVisualStudioCode = false;
  bool get installVisualStudioCode => _installVisualStudioCode;
  void setInstallVisualStudioCode(bool newValue) {
    _installVisualStudioCode = newValue;
    notifyListeners();
  }

  bool _installAndroidStudio = true;
  bool get installAndroidStudio => _installAndroidStudio;
  void setInstallAndroidStudio(bool newValue) {
    _installAndroidStudio = newValue;
    notifyListeners();
  }

  bool _installIntelliJIDEA = false;
  bool get installIntelliJIDEA => _installIntelliJIDEA;
  void setInstallIntelliJIDEA(bool newValue) {
    _installIntelliJIDEA = newValue;
    notifyListeners();
  }

  bool _installGit = true;
  bool get installGit => _installGit;
  void setInstallGit(bool newValue) {
    _installGit = newValue;
    notifyListeners();
  }

  FlutterChannel _flutterChannel = FlutterChannel.stable;
  FlutterChannel get flutterChannel => _flutterChannel;
  void setFlutterChannel(FlutterChannel newValue) {
    _flutterChannel = newValue;
    notifyListeners();
  }

  Future<void> onBrowsePressed() async {
    String initialDirectory;
    if (Platform.isMacOS || Platform.isWindows) {
      initialDirectory = await _localStorageService.getAppDocDirectoryPath();
    }
    final String directoryPath = await file_selector.getDirectoryPath(
      initialDirectory: initialDirectory,
      confirmButtonText: 'Install Here',
    );

    if (directoryPath == null || directoryPath == '') {
      setChooseFolderTextFieldHasError(true);
      showSnackBar(
        title: 'Error Occured',
        message: 'You have to choose an installation path!',
      );
      return;
    }

    setChooseFolderTextFieldHasError(false);
    setInstallationPath(directoryPath);
    chooseFolderController.text = installationPath;
  }

  dynamic showSnackBar({
    String title,
    @required String message,
  }) {
    _snackbarService.showSnackbar(
      title: title,
      message: message,
    );
  }

  Future<void> intialize({
    @required UserChoice userChoice,
  }) async {
    if (userChoice != null) {
      chooseFolderController.text = userChoice.installationPath;
      setFlutterChannel(userChoice.flutterChannel);
      setInstallAndroidStudio(userChoice.installAndroidStudio);
      setInstallGit(userChoice.installGit);
      setInstallIntelliJIDEA(userChoice.installIntelliJIDEA);
      setInstallVisualStudioCode(userChoice.installVisualStudioCode);
    } else {
      setInstallationPath(await _localStorageService.getAppDocDirectoryPath());
      chooseFolderController.text = _installationPath;
    }
  }
}
