import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class ScriptRelease {
  final String? name;
  final DownloadLinks downloadLinks;

  const ScriptRelease({
    required this.name,
    required this.downloadLinks,
  });

  ScriptRelease copyWith({
    String? name,
    DownloadLinks? downloadLinks,
  }) {
    return ScriptRelease(
      name: name ?? this.name,
      downloadLinks: downloadLinks ?? this.downloadLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'download_links': downloadLinks.toMap(),
    };
  }

  factory ScriptRelease.fromMap(Map<String, dynamic> map) {
    return ScriptRelease(
      name: map['name'],
      downloadLinks: DownloadLinks.fromMap(map['download_links']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScriptRelease.fromJson(String source) =>
      ScriptRelease.fromMap(json.decode(source));

  @override
  String toString() =>
      'ScriptRelease(name: $name, downloadLinks: $downloadLinks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScriptRelease &&
        other.name == name &&
        other.downloadLinks == downloadLinks;
  }

  @override
  int get hashCode => name.hashCode ^ downloadLinks.hashCode;
}
