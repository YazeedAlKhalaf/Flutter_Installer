import 'dart:convert';

import 'package:flutter_installer/src/app/models/github_release_asset.model.dart';

class GithubRelease {
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
  GithubRelease.fromMap(Map<String, dynamic> map)
      : url = map['url'].toString(),
        assetsUrl = map['assets_url'].toString(),
        uploadUrl = map['upload_url'].toString(),
        htmlUrl = map['html_url'].toString(),
        id = int.parse(map['id'].toString()),
        nodeId = map['node_id'].toString(),
        tagName = map['tag_name'].toString(),
        targetCommitish = map['target_commitish'].toString(),
        name = map['name'].toString(),
        draft = map['draft'] as bool,
        prerelease = map['prerelease'] as bool,
        createdAt = map['created_at'].toString(),
        publishedAt = map['published_at'].toString(),
        assets = List<GithubReleaseAsset>.from(
          map['assets']?.map((dynamic x) =>
                  GithubReleaseAsset.fromMap(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        );
  
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


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'assets': assets?.map((dynamic x) => x?.toMap())?.toList(),
    };
  }

  
  String toJson() => json.encode(toMap());

  GithubRelease fromJson(String source) =>
      GithubRelease.fromMap(json.decode(source) as Map<String, dynamic>);
}
