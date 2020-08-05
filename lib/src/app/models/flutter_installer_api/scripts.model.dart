import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';

class Scripts {
  ScriptRelease appendToPath;
  ScriptRelease dist;

  Scripts({this.appendToPath, this.dist});

  Scripts.fromJson(Map<String, dynamic> json) {
    appendToPath = json['append_to_path'] != null
        ? new ScriptRelease.fromJson(json['append_to_path'])
        : null;
    dist =
        json['dist'] != null ? new ScriptRelease.fromJson(json['dist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appendToPath != null) {
      data['append_to_path'] = this.appendToPath.toJson();
    }
    if (this.dist != null) {
      data['dist'] = this.dist.toJson();
    }
    return data;
  }
}
