import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsService {
  final Logger log = getLogger('SharedPrefsService');

  Future<bool> saveValue(String key, dynamic value) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    log.d(
      '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $value',
    );

    if (value is String) {
      return _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return _sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return _sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      return _sharedPreferences.setStringList(key, value);
    }

    return false;
  }

  Future<Object> getValue(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final Object value = _sharedPreferences.get(key);
    log.d(
      '(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value',
    );
    return value;
  }

  Future<bool> removeValue(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final bool result = await _sharedPreferences.remove(key);
    return result;
  }
}
