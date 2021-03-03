import 'dart:convert';

class GithubReleaseAsset {
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
  GithubReleaseAsset.fromMap(Map<String, dynamic> map)
      : url = map['url'].toString(),
        id = int.parse(map['id'].toString()),
        nodeId = map['node_id'].toString(),
        name = map['name'].toString(),
        label = map['label'].toString(),
        contentType = map['content_type'].toString(),
        state = map['state'].toString(),
        downloadCount = int.parse(map['download_count'].toString()),
        createdAt = map['created_at'].toString(),
        publishedAt = map['published_at'].toString(),
        browserDownloadUrl = map['browser_download_url'].toString();

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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


  String toJson() => json.encode(toMap());

  GithubReleaseAsset fromJson(String source) =>
      GithubReleaseAsset.fromMap(json.decode(source) as Map<String, dynamic>);
}
