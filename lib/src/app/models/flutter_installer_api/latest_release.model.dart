import 'package:flutter_installer/src/app/models/flutter_installer_api/latest.model.dart';

class LatestRelease {
  LatestRelease({this.latest});

  LatestRelease.fromJson(Map<String, dynamic> json) {
    latest = json['latest'] != null
        ? Latest.fromJson(json['latest'] as Map<String, dynamic>)
        : null;
  }
  Latest latest;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latest != null) {
      data['latest'] = latest.toJson();
    }
    return data;
  }
}
