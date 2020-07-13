import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_installer/src/app/models/current_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';

class Releases {
  final String baseUrl;
  final CurrentRelease currentRelease;
  final List<FlutterRelease> releases;

  const Releases({
    @required this.baseUrl,
    @required this.currentRelease,
    @required this.releases,
  });

  Map<String, dynamic> toMap() {
    return {
      'base_url': baseUrl,
      'current_release': currentRelease?.toMap(),
      'releases': releases?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Releases fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Releases(
      baseUrl: map['base_url'],
      currentRelease: CurrentRelease.fromMap(map['current_release']),
      releases: List<FlutterRelease>.from(
          map['releases']?.map((x) => FlutterRelease.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Releases fromJson(String source) => fromMap(json.decode(source));
}
