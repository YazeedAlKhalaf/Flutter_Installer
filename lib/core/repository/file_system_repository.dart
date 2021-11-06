import 'package:file_selector/file_selector.dart' as file_selector;

class FileSystemRepository {
  Future<String?> getDirectoryPath() async {
    return await file_selector.getDirectoryPath(
      confirmButtonText: "Install Here",
    );
  }
}
