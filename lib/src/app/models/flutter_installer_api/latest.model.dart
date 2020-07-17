import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';

class Latest {
  Latest({
    this.androidStudio,
    this.visualStudioCode,
    this.intellijIdea,
  });

  AppRelease androidStudio;
  AppRelease visualStudioCode;
  AppRelease intellijIdea;

  factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        androidStudio: AppRelease.fromJson(json["android_studio"]),
        visualStudioCode: AppRelease.fromJson(json["visual_studio_code"]),
        intellijIdea: AppRelease.fromJson(json["intellij_idea"]),
      );

  Map<String, dynamic> toJson() => {
        "android_studio": androidStudio.toJson(),
        "visual_studio_code": visualStudioCode.toJson(),
        "intellij_idea": intellijIdea.toJson(),
      };
}
