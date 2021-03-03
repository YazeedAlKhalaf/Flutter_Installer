import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class LocalStorageService {
  // final Logger log = getLogger('PreferencesService');

  String _tempPath;
  String get tempPath => _tempPath;

  String _appDocPath;
  String get appDocPath => _appDocPath;

  Future<String> getTempDiretoryPath() async {
    final Directory tempDir = await getTemporaryDirectory();

    return tempDir.path;
  }

  Future<String> getAppDocDirectoryPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    return appDocDir.path;
  }

  Future<void> initialize() async {
    await getTempDiretoryPath();
    await getAppDocDirectoryPath();
  }
}
