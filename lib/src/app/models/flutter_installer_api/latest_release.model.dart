import 'dart:convert';

import 'package:flutter_installer/src/app/models/flutter_installer_api/latest.model.dart';

LatestRelease latestReleaseFromJson(String str) =>
    LatestRelease.fromJson(json.decode(str));

String latestReleaseToJson(LatestRelease data) => json.encode(data.toJson());

class LatestRelease {
  LatestRelease({
    this.latest,
  });

  Latest latest;

  factory LatestRelease.fromJson(Map<String, dynamic> json) => LatestRelease(
        latest: Latest.fromJson(json["latest"]),
      );

  Map<String, dynamic> toJson() => {
        "latest": latest.toJson(),
      };
}
