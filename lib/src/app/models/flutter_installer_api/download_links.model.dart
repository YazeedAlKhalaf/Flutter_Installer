class DownloadLinks {
  DownloadLinks({
    this.windows,
    this.linux,
    this.macos,
  });

  factory DownloadLinks.fromJson(Map<String, dynamic> json) => DownloadLinks(
        windows: json['windows'].toString(),
        linux: json['linux'].toString(),
        macos: json['macos'].toString(),
      );
  String windows;
  String linux;
  String macos;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'windows': windows,
        'linux': linux,
        'macos': macos,
      };
}
