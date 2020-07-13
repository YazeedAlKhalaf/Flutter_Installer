import 'dart:io';

import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomizeViewModel extends CustomBaseViewModel {
  final SnackbarService _snackbarService = SnackbarService();
  final TextEditingController chooseFolderController = TextEditingController();

  bool _textFieldHasError = false;
  bool get textFieldHasError => _textFieldHasError;
  void setTextFieldHasError(bool newValue) {
    _textFieldHasError = newValue;
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

  Future<void> onBrowsePressed() async {
    String initialDirectory;
    if (Platform.isMacOS || Platform.isWindows) {
      initialDirectory = (await getApplicationDocumentsDirectory()).path;
    }
    final FileChooserResult result = await showOpenPanel(
      allowsMultipleSelection: false,
      canSelectDirectories: true,
      initialDirectory: initialDirectory,
    );

    if (result.canceled) {
      setTextFieldHasError(true);
      showSnackBar(
        title: 'Error Occured',
        message: 'You have to choose an installation path!',
        iconData: Icons.close,
      );
      return;
    }

    setTextFieldHasError(false);
    setInstallationPath(result.paths.join('\n'));
    chooseFolderController.text = installationPath;
  }

  showSnackBar({
    String title,
    @required String message,
    IconData iconData,
  }) {
    _snackbarService.showSnackbar(
      iconData: iconData,
      title: title,
      message: message,
    );
  }
}
