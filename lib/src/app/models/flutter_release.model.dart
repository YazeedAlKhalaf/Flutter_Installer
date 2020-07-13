import 'dart:convert';

import 'package:flutter/foundation.dart';

class FlutterRelease {
  final String hash;
  final String channel;
  final String version;
  final String releaseDate;
  final String archive;
  final String sha256;

  const FlutterRelease({
    @required this.hash,
    @required this.channel,
    @required this.version,
    @required this.releaseDate,
    @required this.archive,
    @required this.sha256,
  });

  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
      'channel': channel,
      'version': version,
      'release_date': releaseDate,
      'archive': archive,
      'sha256': sha256,
    };
  }

  static FlutterRelease fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FlutterRelease(
      hash: map['hash'],
      channel: map['channel'],
      version: map['version'],
      releaseDate: map['release_date'],
      archive: map['archive'],
      sha256: map['sha256'],
    );
  }

  String toJson() => json.encode(toMap());

  static FlutterRelease fromJson(String source) => fromMap(json.decode(source));
}
