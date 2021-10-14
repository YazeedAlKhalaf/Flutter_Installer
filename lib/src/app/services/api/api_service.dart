import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/latest_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
import 'package:flutter_installer/src/app/models/releases.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/api/my_client.dart';
import 'package:flutter_installer/src/app/utils/logger.dart';

enum FlutterReleasePlatform {
  macOS,
  linux,
  windows,
}

@lazySingleton
class ApiService {
  final Logger logger = getLogger('ApiService');

  final String baseUrlForFlutterRelease = 'https://storage.googleapis.com/flutter_infra/releases';

  final MyClient myClient = MyClient(http.Client());

  Future getAllFlutterReleases(
    FlutterReleasePlatform platform,
  ) async {
    late Response response;
    try {
      switch (platform) {
        case FlutterReleasePlatform.windows:
          response = await myClient.get(
            Uri.parse('$baseUrlForFlutterRelease/releases_windows.json'),
          );
          break;
        case FlutterReleasePlatform.macOS:
          response = await myClient.get(
            Uri.parse('$baseUrlForFlutterRelease/releases_macos.json'),
          );
          break;
        case FlutterReleasePlatform.linux:
          response = await myClient.get(
            Uri.parse('$baseUrlForFlutterRelease/releases_linux.json'),
          );
          break;
      }
      Map<String, dynamic> data = json.decode(response.body);
      Releases releases = Releases.fromMap(data);

      return releases;
    } catch (e) {
      logger.wtf(e.toString());
    }
  }

  Future<FlutterRelease?> getLatestRelease({
    required FlutterChannel? flutterChannel,
    required FlutterReleasePlatform platform,
  }) async {
    final Releases releases = await (getAllFlutterReleases(platform) as FutureOr<Releases>);
    String? hash;

    switch (flutterChannel) {
      case FlutterChannel.beta:
        hash = releases.currentRelease.beta;
        break;
      case FlutterChannel.dev:
        hash = releases.currentRelease.dev;
        break;
      case FlutterChannel.stable:
        hash = releases.currentRelease.stable;
        break;
      case null:
        break;
    }

    FlutterRelease? latestFlutterRelease;

    releases.releases.forEach((FlutterRelease flutterRelease) {
      if (flutterRelease.hash == hash) {
        latestFlutterRelease = flutterRelease;
      }
    });

    return latestFlutterRelease;
  }

  Future<GithubReleaseAsset> getLatestGitForWindowsRelease() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://api.github.com/repos/git-for-windows/git/releases/latest'),
    );

    Map<String, dynamic> data = json.decode(response.body);
    GithubRelease githubRelease = GithubRelease.fromMap(data);

    GithubReleaseAsset githubReleaseAsset = githubRelease.assets[2];

    return githubReleaseAsset;
  }

  Future<AppRelease> getLatestAndroidStudioRelease() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://flutter-installer-api.herokuapp.com/api/v1/latest_release'),
    );

    Map<String, dynamic> data = json.decode(response.body);

    LatestRelease latestRelease = LatestRelease.fromMap(data);

    AppRelease appRelease = latestRelease.latest.androidStudio;

    return appRelease;
  }

  Future<AppRelease> getLatestVisualStudioCodeRelease() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://flutter-installer-api.herokuapp.com/api/v1/latest_release'),
    );

    Map<String, dynamic> data = json.decode(response.body);

    LatestRelease latestRelease = LatestRelease.fromMap(data);

    AppRelease appRelease = latestRelease.latest.visualStudioCode;

    return appRelease;
  }

  Future<AppRelease> getLatestIntelliJIDEARelease() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://flutter-installer-api.herokuapp.com/api/v1/latest_release'),
    );

    Map<String, dynamic> data = json.decode(response.body);

    LatestRelease latestRelease = LatestRelease.fromMap(data);

    AppRelease appRelease = latestRelease.latest.intellijIdea;

    return appRelease;
  }

  Future<ScriptRelease> getLatestAppendToPathScript() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://flutter-installer-api.herokuapp.com/api/v1/latest_release'),
    );

    Map<String, dynamic> data = json.decode(response.body);

    LatestRelease latestRelease = LatestRelease.fromMap(data);

    ScriptRelease scriptRelease = latestRelease.latest.scripts.appendToPath;

    return scriptRelease;
  }

  Future<ScriptRelease> getLatestDistScript() async {
    Response response;
    response = await myClient.get(
      Uri.parse('https://flutter-installer-api.herokuapp.com/api/v1/latest_release'),
    );

    Map<String, dynamic> data = json.decode(response.body);

    LatestRelease latestRelease = LatestRelease.fromMap(data);

    ScriptRelease scriptRelease = latestRelease.latest.scripts.dist;

    return scriptRelease;
  }
}
