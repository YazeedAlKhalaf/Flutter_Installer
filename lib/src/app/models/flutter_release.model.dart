import 'dart:convert';

import 'package:flutter/foundation.dart';

class FlutterRelease {
  final String? hash;
  final String? channel;
  final String? version;
  final String? releaseDate;
  final String? archive;
  final String? sha256;

  const FlutterRelease({
    required this.hash,
    required this.channel,
    required this.version,
    required this.releaseDate,
    required this.archive,
    required this.sha256,
  });

  FlutterRelease copyWith({
    String? hash,
    String? channel,
    String? version,
    String? releaseDate,
    String? archive,
    String? sha256,
  }) {
    return FlutterRelease(
      hash: hash ?? this.hash,
      channel: channel ?? this.channel,
      version: version ?? this.version,
      releaseDate: releaseDate ?? this.releaseDate,
      archive: archive ?? this.archive,
      sha256: sha256 ?? this.sha256,
    );
  }

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

  factory FlutterRelease.fromMap(Map<String, dynamic> map) {
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

  factory FlutterRelease.fromJson(String source) =>
      FlutterRelease.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlutterRelease(hash: $hash, channel: $channel, version: $version, releaseDate: $releaseDate, archive: $archive, sha256: $sha256)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlutterRelease &&
        other.hash == hash &&
        other.channel == channel &&
        other.version == version &&
        other.releaseDate == releaseDate &&
        other.archive == archive &&
        other.sha256 == sha256;
  }

  @override
  int get hashCode {
    return hash.hashCode ^
        channel.hashCode ^
        version.hashCode ^
        releaseDate.hashCode ^
        archive.hashCode ^
        sha256.hashCode;
  }
}
