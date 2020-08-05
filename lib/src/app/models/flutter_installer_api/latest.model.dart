import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/scripts.model.dart';

class Latest {
  AppRelease androidStudio;
  AppRelease visualStudioCode;
  AppRelease intellijIdea;
  Scripts scripts;

  Latest(
      {this.androidStudio,
      this.visualStudioCode,
      this.intellijIdea,
      this.scripts});

  Latest.fromJson(Map<String, dynamic> json) {
    androidStudio = json['android_studio'] != null
        ? AppRelease.fromJson(json['android_studio'])
        : null;
    visualStudioCode = json['visual_studio_code'] != null
        ? AppRelease.fromJson(json['visual_studio_code'])
        : null;
    intellijIdea = json['intellij_idea'] != null
        ? AppRelease.fromJson(json['intellij_idea'])
        : null;
    scripts =
        json['scripts'] != null ? Scripts.fromJson(json['scripts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.androidStudio != null) {
      data['android_studio'] = this.androidStudio.toJson();
    }
    if (this.visualStudioCode != null) {
      data['visual_studio_code'] = this.visualStudioCode.toJson();
    }
    if (this.intellijIdea != null) {
      data['intellij_idea'] = this.intellijIdea.toJson();
    }
    if (this.scripts != null) {
      data['scripts'] = this.scripts.toJson();
    }
    return data;
  }
}
