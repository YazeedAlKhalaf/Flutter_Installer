import 'dart:convert';

import 'package:flutter/foundation.dart';

class FlutterRelease {
  const FlutterRelease({
    @required this.hash,
    @required this.channel,
    @required this.version,
    @required this.releaseDate,
    @required this.archive,
    @required this.sha256,
  });

  FlutterRelease.fromMap(Map<String, dynamic> map)
      : hash = map['hash'].toString(),
        channel = map['channel'].toString(),
        version = map['version'].toString(),
        releaseDate = map['release_date'].toString(),
        archive = map['archive'].toString(),
        sha256 = map['sha256'].toString();
        
  final String hash;
  final String channel;
  final String version;
  final String releaseDate;
  final String archive;
  final String sha256;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'channel': channel,
      'version': version,
      'release_date': releaseDate,
      'archive': archive,
      'sha256': sha256,
    };
  }

  String toJson() => json.encode(toMap());

  FlutterRelease fromJson(String source) =>
      FlutterRelease.fromMap(json.decode(source) as Map<String, dynamic>);
}
