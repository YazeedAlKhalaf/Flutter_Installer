import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_installer/src/app/utils/logger.dart';

@lazySingleton
class LocalStorageService {
  final Logger log = getLogger('LocalStorageService');

  String _tempPath;
  String get tempPath => _tempPath;

  String _appDocPath;
  String get appDocPath => _appDocPath;

  Future<String> getTempDiretoryPath() async {
    Directory tempDir = await getTemporaryDirectory();
    log.d("Got temp directory path: ${tempDir.path}");

    _tempPath = tempDir.path;

    return _tempPath;
  }

  Future<String> getAppDocDirectoryPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    log.d("Got app doc directory path: ${appDocDir.path}");

    _appDocPath = appDocDir.path;

    return _appDocPath;
  }

  Future<void> initialize() async {
    await getTempDiretoryPath();
    await getAppDocDirectoryPath();
  }
}
