import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_installer/src/app/models/current_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';

class Releases {
  const Releases({
    @required this.baseUrl,
    @required this.currentRelease,
    @required this.releases,
  });
  Releases.fromMap(Map<String, dynamic> map)
      : baseUrl = map['base_url'].toString(),
        currentRelease = CurrentRelease.fromMap(
            map['current_release'] as Map<String, dynamic>),
        releases = List<FlutterRelease>.from(
          map['releases']?.map(
            (dynamic x) => FlutterRelease.fromMap(x as Map<String, dynamic>),
          ) as Iterable<dynamic>,
        );
  final String baseUrl;
  final CurrentRelease currentRelease;
  final List<FlutterRelease> releases;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_url': baseUrl,
      'current_release': currentRelease?.toMap(),
      'releases': releases?.map((dynamic x) => x?.toMap())?.toList(),
    };
  }

  String toJson() => json.encode(toMap());

  Releases fromJson(String source) =>
      Releases.fromMap(json.decode(source) as Map<String, dynamic>);
}
