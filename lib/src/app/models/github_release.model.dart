import 'dart:convert';

import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';

class GithubRelease {
  final String url;
  final String assetsUrl;
  final String uploadUrl;
  final String htmlUrl;
  final int id;
  final String nodeId;
  final String tagName;
  final String targetCommitish;
  final String name;
  final bool draft;
  // author
  final bool prerelease;
  final String createdAt;
  final String publishedAt;
  final List<GithubReleaseAsset> assets;

  const GithubRelease({
    this.url,
    this.assetsUrl,
    this.uploadUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.tagName,
    this.targetCommitish,
    this.name,
    this.draft,
    this.prerelease,
    this.createdAt,
    this.publishedAt,
    this.assets,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'assets_url': assetsUrl,
      'upload_url': uploadUrl,
      'html_url': htmlUrl,
      'id': id,
      'node_id': nodeId,
      'tag_name': tagName,
      'target_commitish': targetCommitish,
      'name': name,
      'draft': draft,
      'prerelease': prerelease,
      'created_at': createdAt,
      'published_at': publishedAt,
      'assets': assets?.map((x) => x?.toMap())?.toList(),
    };
  }

  static GithubRelease fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GithubRelease(
      url: map['url'],
      assetsUrl: map['assets_url'],
      uploadUrl: map['upload_url'],
      htmlUrl: map['html_url'],
      id: map['id'],
      nodeId: map['node_id'],
      tagName: map['tag_name'],
      targetCommitish: map['target_commitish'],
      name: map['name'],
      draft: map['draft'],
      prerelease: map['prerelease'],
      createdAt: map['created_at'],
      publishedAt: map['published_at'],
      assets: List<GithubReleaseAsset>.from(
          map['assets']?.map((x) => GithubReleaseAsset.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static GithubRelease fromJson(String source) => fromMap(json.decode(source));
}
