class DownloadLinks {
  DownloadLinks({
    this.windows,
    this.linux,
    this.macos,
  });

  String windows;
  String linux;
  String macos;

  factory DownloadLinks.fromJson(Map<String, dynamic> json) => DownloadLinks(
        windows: json["windows"],
        linux: json["linux"],
        macos: json["macos"],
      );

  Map<String, dynamic> toJson() => {
        "windows": windows,
        "linux": linux,
        "macos": macos,
      };
}
