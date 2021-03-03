import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class AppRelease {
  AppRelease({
    this.name,
    this.version,
    this.downloadLinks,
  });
  factory AppRelease.fromJson(Map<String, dynamic> json) => AppRelease(
        name: json['name'].toString(),
        version: json['version'].toString(),
        downloadLinks: DownloadLinks.fromJson(
          json['download_links'] as Map<String, dynamic>,
        ),
      );

  String name;
  String version;
  DownloadLinks downloadLinks;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'version': version,
        'download_links': downloadLinks.toJson(),
      };
}
