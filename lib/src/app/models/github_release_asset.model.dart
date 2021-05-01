import 'dart:convert';

import 'package:flutter/foundation.dart';

class GithubReleaseAsset {
  final String url;
  final int id;
  final String nodeId;
  final String name;
  final String label;
  // uploader
  final String contentType;
  final String state;
  final int downloadCount;
  final String createdAt;
  final String publishedAt;
  final String browserDownloadUrl;

  const GithubReleaseAsset({
    @required this.url,
    @required this.id,
    @required this.nodeId,
    @required this.name,
    @required this.label,
    @required this.contentType,
    @required this.state,
    @required this.downloadCount,
    @required this.createdAt,
    @required this.publishedAt,
    @required this.browserDownloadUrl,
  });

  GithubReleaseAsset copyWith({
    String url,
    int id,
    String nodeId,
    String name,
    String label,
    String contentType,
    String state,
    int downloadCount,
    String createdAt,
    String publishedAt,
    String browserDownloadUrl,
  }) {
    return GithubReleaseAsset(
      url: url ?? this.url,
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      name: name ?? this.name,
      label: label ?? this.label,
      contentType: contentType ?? this.contentType,
      state: state ?? this.state,
      downloadCount: downloadCount ?? this.downloadCount,
      createdAt: createdAt ?? this.createdAt,
      publishedAt: publishedAt ?? this.publishedAt,
      browserDownloadUrl: browserDownloadUrl ?? this.browserDownloadUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'id': id,
      'node_id': nodeId,
      'name': name,
      'label': label,
      'content_type': contentType,
      'state': state,
      'download_count': downloadCount,
      'created_at': createdAt,
      'published_at': publishedAt,
      'browser_download_url': browserDownloadUrl,
    };
  }

  factory GithubReleaseAsset.fromMap(Map<String, dynamic> map) {
    return GithubReleaseAsset(
      url: map['url'],
      id: map['id'],
      nodeId: map['node_id'],
      name: map['name'],
      label: map['label'],
      contentType: map['content_type'],
      state: map['state'],
      downloadCount: map['download_count'],
      createdAt: map['created_at'],
      publishedAt: map['published_at'],
      browserDownloadUrl: map['browser_download_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubReleaseAsset.fromJson(String source) =>
      GithubReleaseAsset.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GithubReleaseAsset(url: $url, id: $id, nodeId: $nodeId, name: $name, label: $label, contentType: $contentType, state: $state, downloadCount: $downloadCount, createdAt: $createdAt, publishedAt: $publishedAt, browserDownloadUrl: $browserDownloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GithubReleaseAsset &&
        other.url == url &&
        other.id == id &&
        other.nodeId == nodeId &&
        other.name == name &&
        other.label == label &&
        other.contentType == contentType &&
        other.state == state &&
        other.downloadCount == downloadCount &&
        other.createdAt == createdAt &&
        other.publishedAt == publishedAt &&
        other.browserDownloadUrl == browserDownloadUrl;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        id.hashCode ^
        nodeId.hashCode ^
        name.hashCode ^
        label.hashCode ^
        contentType.hashCode ^
        state.hashCode ^
        downloadCount.hashCode ^
        createdAt.hashCode ^
        publishedAt.hashCode ^
        browserDownloadUrl.hashCode;
  }
}
