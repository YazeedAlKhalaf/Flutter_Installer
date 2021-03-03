import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/app_release.mode.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/latest_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_installer_api/script_release.model.dart';
import 'package:flutter_installer/src/app/models/flutter_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release.model.dart';
import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';
import 'package:flutter_installer/src/app/models/releases.model.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

enum FlutterReleasePlatform {
  macOS,
  linux,
  windows,
}

@lazySingleton
class ApiService {
  final Logger logger = getLogger('ApiService');

  final Uri baseUrlForFlutterRelease =
      Uri.https('storage.googleapis.com', '/flutter_infra/releases');
  final Uri baseUrlForGitRelease =
      Uri.https('api.github.com', '/repos/git-for-windows/git/releases/latest');
  final Uri baseUrlForLatestRelease = Uri.https(
      'flutter-installer-api.herokuapp.com', '/api/v1/latest_release');
  Future<dynamic> getAllFlutterReleases(
    FlutterReleasePlatform platform,
  ) async {
    Response response;
    try {
      switch (platform) {
        case FlutterReleasePlatform.windows:
          response = await http.get(
            '$baseUrlForFlutterRelease/releases_windows.json' as Uri,
          );
          break;
        case FlutterReleasePlatform.macOS:
          response = await http
              .get('$baseUrlForFlutterRelease/releases_macos.json' as Uri);
          break;
        case FlutterReleasePlatform.linux:
          response = await http
              .get('$baseUrlForFlutterRelease/releases_linux.json' as Uri);
          break;
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final Releases releases = Releases.fromMap(data);

      return releases;
    } catch (e) {
      logger.wtf(e.toString());
    }
  }

  Future<FlutterRelease> getLatestRelease({
    @required FlutterChannel flutterChannel,
    @required FlutterReleasePlatform platform,
  }) async {
    final Releases releases = await getAllFlutterReleases(platform);
    String hash;

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
    }

    FlutterRelease latestFlutterRelease;

    for (final FlutterRelease flutterRelease in releases.releases) {
      if (flutterRelease.hash == hash) {
        latestFlutterRelease = flutterRelease;
      }
    }

    return latestFlutterRelease;
  }

  Future<GithubReleaseAsset> getLatestGitForWindowsRelease() async {
    Response response;
    response = await http.get(
      baseUrlForGitRelease,
    );

    final Map<String, dynamic> data = json.decode(response.body);
    final GithubRelease githubRelease = GithubRelease.fromMap(data);

    // ignore: prefer_final_locals
    GithubReleaseAsset githubReleaseAsset = githubRelease.assets[2];

    return githubReleaseAsset;
  }

  Future<AppRelease> getLatestAndroidStudioRelease() async {
    Response response;
    response = await http.get(baseUrlForLatestRelease);

    final Map<String, dynamic> data = json.decode(response.body);

    final LatestRelease latestRelease = LatestRelease.fromJson(data);

    final AppRelease appRelease = latestRelease.latest.androidStudio;

    return appRelease;
  }

  Future<AppRelease> getLatestVisualStudioCodeRelease() async {
    Response response;
    response = await http.get(baseUrlForLatestRelease);

    final Map<String, dynamic> data = json.decode(response.body);

    final LatestRelease latestRelease = LatestRelease.fromJson(data);

    final AppRelease appRelease = latestRelease.latest.visualStudioCode;

    return appRelease;
  }

  Future<AppRelease> getLatestIntelliJIDEARelease() async {
    Response response;
    response = await http.get(baseUrlForLatestRelease);

    final Map<String, dynamic> data = json.decode(response.body);

    final LatestRelease latestRelease = LatestRelease.fromJson(data);

    final AppRelease appRelease = latestRelease.latest.intellijIdea;

    return appRelease;
  }

  Future<ScriptRelease> getLatestAppendToPathScript() async {
    Response response;
    response = await http.get(baseUrlForLatestRelease);

    final Map<String, dynamic> data = json.decode(response.body);

    final LatestRelease latestRelease = LatestRelease.fromJson(data);

    final ScriptRelease scriptRelease =
        latestRelease.latest.scripts.appendToPath;

    return scriptRelease;
  }

  Future<ScriptRelease> getLatestDistScript() async {
    Response response;
    response = await http.get(baseUrlForLatestRelease);

    final Map<String, dynamic> data = json.decode(response.body);

    final LatestRelease latestRelease = LatestRelease.fromJson(data);

    final ScriptRelease scriptRelease = latestRelease.latest.scripts.dist;

    return scriptRelease;
  }
}
