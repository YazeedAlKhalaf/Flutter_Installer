import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/utils/constants.dart';
import 'package:flutter_installer/src/app/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PreferencesService {
  final log = getLogger('PreferencesService');

  UserChoice _userChoice;
  UserChoice get userChoice => _userChoice;

  Future<UserChoice> getUserChoice() async {
    String userChoiceJSON = await _getValue<String>(userChoiceKey);
    _userChoice = UserChoice.fromJson(userChoiceJSON);
    return _userChoice;
  }

  Future<void> saveUserChoice(UserChoice userChoice) async {
    String userChoiceJSON = userChoice.toJson();
    await _saveValue<String>(userChoiceKey, userChoiceJSON);
    _userChoice = userChoice;
  }

  Future<bool> removeUserChoice(bool value) async {
    bool result = await _removeValue(userChoiceKey);
    return result;
  }

  Future<void> _saveValue<T>(String key, var value) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    log.d(
      '_saveToDisk. key: $key value: $value',
    );

    if (value is String) {
      await _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await _sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  Future _getValue<T>(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    T value = await _sharedPreferences.get(key);
    log.d(
      '_getFromDisk. key: $key value: $value',
    );
    return value;
  }

  Future<bool> _removeValue(String key) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool result = await _sharedPreferences.remove(key);
    return result;
  }
}
