import 'dart:convert';

import 'package:flutter/foundation.dart';

class CurrentRelease {
  final String beta;
  final String dev;
  final String stable;

  const CurrentRelease({
    @required this.beta,
    @required this.dev,
    @required this.stable,
  });

  Map<String, dynamic> toMap() {
    return {
      'beta': beta,
      'dev': dev,
      'stable': stable,
    };
  }

  static CurrentRelease fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CurrentRelease(
      beta: map['beta'],
      dev: map['dev'],
      stable: map['stable'],
    );
  }

  String toJson() => json.encode(toMap());

  static CurrentRelease fromJson(String source) => fromMap(json.decode(source));
}
