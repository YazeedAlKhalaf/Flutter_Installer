import 'dart:convert';

import 'package:flutter/foundation.dart';

class CurrentRelease {
  const CurrentRelease({
    @required this.beta,
    @required this.dev,
    @required this.stable,
  });
  CurrentRelease.fromMap(Map<String, dynamic> map)
      : beta = map['beta'].toString(),
        dev = map['dev'].toString(),
        stable = map['stable'].toString();

  final String beta;
  final String dev;
  final String stable;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beta': beta,
      'dev': dev,
      'stable': stable,
    };
  }

  String toJson() => json.encode(toMap());

  CurrentRelease fromJson(String source) =>
      CurrentRelease.fromMap(json.decode(source) as Map<String, dynamic>);
}
