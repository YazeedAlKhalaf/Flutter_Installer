import 'dart:convert';

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

  UserChoice.defaultChoice({
    this.installAndroidStudio = true,
    this.installationPath,
    this.installVisualStudioCode = false,
    this.installIntelliJIDEA = false,
    this.installGit = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'installationPath': installationPath,
      'installVisualStudioCode': installVisualStudioCode,
      'installAndroidStudio': installAndroidStudio,
      'installIntelliJIDEA': installIntelliJIDEA,
      'installGit': installGit,
    };
  }

  static UserChoice fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserChoice(
      installationPath: map['installationPath'],
      installVisualStudioCode: map['installVisualStudioCode'],
      installAndroidStudio: map['installAndroidStudio'],
      installIntelliJIDEA: map['installIntelliJIDEA'],
      installGit: map['installGit'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserChoice fromJson(String source) => fromMap(json.decode(source));
}
