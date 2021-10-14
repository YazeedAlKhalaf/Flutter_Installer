import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class AppRelease {
  final String? name;
  final String? version;
  final DownloadLinks downloadLinks;

  const AppRelease({
    required this.name,
    required this.version,
    required this.downloadLinks,
  });

  AppRelease copyWith({
    String? name,
    String? version,
    DownloadLinks? downloadLinks,
  }) {
    return AppRelease(
      name: name ?? this.name,
      version: version ?? this.version,
      downloadLinks: downloadLinks ?? this.downloadLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'download_links': downloadLinks.toMap(),
    };
  }

  factory AppRelease.fromMap(Map<String, dynamic> map) {
    return AppRelease(
      name: map['name'],
      version: map['version'],
      downloadLinks: DownloadLinks.fromMap(map['download_links']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppRelease.fromJson(String source) =>
      AppRelease.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppRelease(name: $name, version: $version, downloadLinks: $downloadLinks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppRelease &&
        other.name == name &&
        other.version == version &&
        other.downloadLinks == downloadLinks;
  }

  @override
  int get hashCode => name.hashCode ^ version.hashCode ^ downloadLinks.hashCode;
}
