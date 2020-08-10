import 'package:flutter/material.dart';

enum FlutterChannel {
  dev,
  beta,
  stable,
}

class UserChoice {
  final String installationPath;
  final bool installVisualStudioCode;
  final bool installAndroidStudio;
  final bool installIntelliJIDEA;
  final bool installGit;
  final FlutterChannel flutterChannel;

  UserChoice({
    @required this.installationPath,
    @required this.installVisualStudioCode,
    @required this.installAndroidStudio,
    @required this.installIntelliJIDEA,
    @required this.installGit,
    @required this.flutterChannel,
  });

  UserChoice.defaultChoice({
    this.installAndroidStudio = true,
    this.installationPath,
    this.installVisualStudioCode = false,
    this.installIntelliJIDEA = false,
    this.installGit = true,
    this.flutterChannel = FlutterChannel.stable,
  });

  Map<String, dynamic> toMap() {
    return {
      'installationPath': installationPath,
      'installVisualStudioCode': installVisualStudioCode,
      'installAndroidStudio': installAndroidStudio,
      'installIntelliJIDEA': installIntelliJIDEA,
      'installGit': installGit,
      'flutterChannel': flutterChannel,
    };
  }
}
