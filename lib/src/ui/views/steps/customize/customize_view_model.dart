import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';

class CustomizeViewModel extends CustomBaseViewModel {
  final TextEditingController chooseFolderController = TextEditingController();

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
}
