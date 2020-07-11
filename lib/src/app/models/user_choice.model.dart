import 'package:flutter/material.dart';

class UserChoice {
  final String installationPath;
  final bool installVisualStudioCode;
  final bool installAndroidStudio;
  final bool installIntelliJIDEA;
  final bool installGit;

  UserChoice({
    @required this.installationPath,
    @required this.installVisualStudioCode,
    @required this.installAndroidStudio,
    @required this.installIntelliJIDEA,
    @required this.installGit,
  });
}
