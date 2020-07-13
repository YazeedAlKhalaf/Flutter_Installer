import 'dart:convert';

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
    this.url,
    this.id,
    this.nodeId,
    this.name,
    this.label,
    this.contentType,
    this.state,
    this.downloadCount,
    this.createdAt,
    this.publishedAt,
    this.browserDownloadUrl,
  });

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

  static GithubReleaseAsset fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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

  static GithubReleaseAsset fromJson(String source) =>
      fromMap(json.decode(source));
}
