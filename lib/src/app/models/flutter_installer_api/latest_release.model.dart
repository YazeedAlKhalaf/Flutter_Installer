import 'package:flutter_installer/src/app/models/flutter_installer_api/latest.model.dart';

class LatestRelease {
  Latest latest;

  LatestRelease({this.latest});

  LatestRelease.fromJson(Map<String, dynamic> json) {
    latest =
        json['latest'] != null ? new Latest.fromJson(json['latest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latest != null) {
      data['latest'] = this.latest.toJson();
    }
    return data;
  }
}
