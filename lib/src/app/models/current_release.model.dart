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

  CurrentRelease copyWith({
    String beta,
    String dev,
    String stable,
  }) {
    return CurrentRelease(
      beta: beta ?? this.beta,
      dev: dev ?? this.dev,
      stable: stable ?? this.stable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'beta': beta,
      'dev': dev,
      'stable': stable,
    };
  }

  factory CurrentRelease.fromMap(Map<String, dynamic> map) {
    return CurrentRelease(
      beta: map['beta'],
      dev: map['dev'],
      stable: map['stable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentRelease.fromJson(String source) =>
      CurrentRelease.fromMap(json.decode(source));

  @override
  String toString() =>
      'CurrentRelease(beta: $beta, dev: $dev, stable: $stable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentRelease &&
        other.beta == beta &&
        other.dev == dev &&
        other.stable == stable;
  }

  @override
  int get hashCode => beta.hashCode ^ dev.hashCode ^ stable.hashCode;
}
