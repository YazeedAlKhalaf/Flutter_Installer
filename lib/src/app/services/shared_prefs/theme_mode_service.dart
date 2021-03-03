import 'package:flutter_installer/src/app/services/shared_prefs/shared_prefs_service.dart';
import 'package:flutter_installer/src/app/utils/constants.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

class ThemeModeService extends SharedPrefsService implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    return await getTheme() as String;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    return saveTheme(value);
  }

  String _themeMode;
  String get themeMode => _themeMode;

  Future<Object> getTheme() async {
    return getValue(Constants.themeModeKey);
  }

  Future<bool> saveTheme(String value) async {
    _themeMode = value;
    return saveValue(Constants.themeModeKey, value);
  }

  Future<bool> removeTheme(String value) async {
    return removeValue(Constants.themeModeKey);
  }
}
