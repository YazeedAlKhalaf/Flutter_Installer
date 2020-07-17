import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class AppRelease {
  AppRelease({
    this.name,
    this.version,
    this.downloadLinks,
  });

  String name;
  String version;
  DownloadLinks downloadLinks;

  factory AppRelease.fromJson(Map<String, dynamic> json) => AppRelease(
        name: json["name"],
        version: json["version"],
        downloadLinks: DownloadLinks.fromJson(json["download_links"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "version": version,
        "download_links": downloadLinks.toJson(),
      };
}
