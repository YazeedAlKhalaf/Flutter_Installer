import 'package:flutter_installer/src/app/models/flutter_installer_api/download_links.model.dart';

class ScriptRelease {
  String name;
  DownloadLinks downloadLinks;

  ScriptRelease({this.name, this.downloadLinks});

  ScriptRelease.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    downloadLinks = json['download_links'] != null
        ? new DownloadLinks.fromJson(json['download_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.downloadLinks != null) {
      data['download_links'] = this.downloadLinks.toJson();
    }
    return data;
  }
}
