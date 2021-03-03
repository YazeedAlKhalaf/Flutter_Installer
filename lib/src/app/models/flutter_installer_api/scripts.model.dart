import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';

class Scripts {
  Scripts({this.appendToPath, this.dist});

  Scripts.fromJson(Map<String, dynamic> json) {
    appendToPath = json['append_to_path'] != null
        ? ScriptRelease.fromJson(
            json['append_to_path'] as Map<String, dynamic>)
        : null;
    dist = json['dist'] != null
        ? ScriptRelease.fromJson(json['dist'] as Map<String, dynamic>)
        : null;
  }
  ScriptRelease appendToPath;
  ScriptRelease dist;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appendToPath != null) {
      data['append_to_path'] = appendToPath.toJson();
    }
    if (dist != null) {
      data['dist'] = dist.toJson();
    }
    return data;
  }
}
