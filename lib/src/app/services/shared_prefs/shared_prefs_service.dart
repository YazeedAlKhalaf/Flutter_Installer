import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsService {
  final log = getLogger('SharedPrefsService');

  Future<bool> saveValue(String key, var value) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    log.d(
      'saveValue | key: $key value: $value',
    );

    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    }

    return false;
  }

  Future getValue(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    var value = _sharedPreferences.get(key);
    log.d(
      'getValue | key: $key value: $value',
    );
    return value;
  }

  Future<bool> removeValue(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool result = await _sharedPreferences.remove(key);

    log.d(
      'removeValue | key: $key',
    );

    return result;
  }
}
