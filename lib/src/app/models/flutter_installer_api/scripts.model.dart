import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';

class Scripts {
  final ScriptRelease appendToPath;
  final ScriptRelease dist;

  const Scripts({
    required this.appendToPath,
    required this.dist,
  });

  Scripts copyWith({
    ScriptRelease? appendToPath,
    ScriptRelease? dist,
  }) {
    return Scripts(
      appendToPath: appendToPath ?? this.appendToPath,
      dist: dist ?? this.dist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'append_to_path': appendToPath.toMap(),
      'dist': dist.toMap(),
    };
  }

  factory Scripts.fromMap(Map<String, dynamic> map) {
    return Scripts(
      appendToPath: ScriptRelease.fromMap(map['append_to_path']),
      dist: ScriptRelease.fromMap(map['dist']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Scripts.fromJson(String source) =>
      Scripts.fromMap(json.decode(source));

  @override
  String toString() => 'Scripts(appendToPath: $appendToPath, dist: $dist)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Scripts &&
        other.appendToPath == appendToPath &&
        other.dist == dist;
  }

  @override
  int get hashCode => appendToPath.hashCode ^ dist.hashCode;
}
