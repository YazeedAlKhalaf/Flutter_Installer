import 'dart:io';

import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class LocalStorageService {
  final Logger log = getLogger('PreferencesService');

  String _tempPath;
  String get tempPath => _tempPath;

  String _appDocPath;
  String get appDocPath => _appDocPath;

  Future<String> getTempDiretoryPath() async {
    Directory tempDir = await getTemporaryDirectory();

    _tempPath = tempDir.path;

    return _tempPath;
  }

  Future<String> getAppDocDirectoryPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    _appDocPath = appDocDir.path;

    return _appDocPath;
  }

  Future<void> initialize() async {
    await getTempDiretoryPath();
    await getAppDocDirectoryPath();
  }
}
