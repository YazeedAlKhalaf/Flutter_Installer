import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/scripts.model.dart';

class Latest {
  Latest(
      {this.androidStudio,
      this.visualStudioCode,
      this.intellijIdea,
      this.scripts});

  Latest.fromJson(Map<String, dynamic> json) {
    androidStudio = json['android_studio'] != null
        ? AppRelease.fromJson(
            json['android_studio'] as Map<String, dynamic>,
          )
        : null;
    visualStudioCode = json['visual_studio_code'] != null
        ? AppRelease.fromJson(
            json['visual_studio_code'] as Map<String, dynamic>,
          )
        : null;
    intellijIdea = json['intellij_idea'] != null
        ? AppRelease.fromJson(
            json['intellij_idea'] as Map<String, dynamic>,
          )
        : null;
    scripts = json['scripts'] != null
        ? Scripts.fromJson(
            json['scripts'] as Map<String, dynamic>,
          )
        : null;
  }

  AppRelease androidStudio;
  AppRelease visualStudioCode;
  AppRelease intellijIdea;
  Scripts scripts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (androidStudio != null) {
      data['android_studio'] = androidStudio.toJson();
    }
    if (visualStudioCode != null) {
      data['visual_studio_code'] = visualStudioCode.toJson();
    }
    if (intellijIdea != null) {
      data['intellij_idea'] = intellijIdea.toJson();
    }
    if (scripts != null) {
      data['scripts'] = scripts.toJson();
    }
    return data;
  }
}
