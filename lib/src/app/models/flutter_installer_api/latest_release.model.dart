import 'dart:convert';

import 'package:flutter_installer/src/app/models/flutter_installer_api/latest.model.dart';

class LatestRelease {
  final Latest latest;

  const LatestRelease({
    required this.latest,
  });

  LatestRelease copyWith({
    Latest? latest,
  }) {
    return LatestRelease(
      latest: latest ?? this.latest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latest': latest.toMap(),
    };
  }

  factory LatestRelease.fromMap(Map<String, dynamic> map) {
    return LatestRelease(
      latest: Latest.fromMap(map['latest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LatestRelease.fromJson(String source) => LatestRelease.fromMap(json.decode(source));

  @override
  String toString() => 'LatestRelease(latest: $latest)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatestRelease && other.latest == latest;
  }

  @override
  int get hashCode => latest.hashCode;
}
