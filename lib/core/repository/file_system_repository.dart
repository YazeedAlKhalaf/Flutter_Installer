import 'package:file_selector/file_selector.dart' as file_selector;
import 'package:flutter_installer/core/utils/fi_logger.dart';

class FileSystemRepository {
  final Logger _fiLogger = FiLogger.getLogger("FileSystemRepository");

  Future<String?> getDirectoryPath() async {
    final String? path = await file_selector.getDirectoryPath();
    _fiLogger.fine("getDirectoryPath() | path: $path");

    return path;
  }
}
