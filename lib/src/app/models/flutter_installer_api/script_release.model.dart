import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class ScriptRelease {

  ScriptRelease({this.name, this.downloadLinks});

  ScriptRelease.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    downloadLinks = json['download_links'] != null
        ? DownloadLinks.fromJson(json['download_links'] as Map<String, dynamic>)
        : null;
  }
  String name;
  DownloadLinks downloadLinks;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (downloadLinks != null) {
      data['download_links'] = downloadLinks.toJson();
    }
    return data;
  }
}
