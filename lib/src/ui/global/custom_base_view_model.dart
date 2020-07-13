import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:stacked/stacked.dart';

class CustomBaseViewModel extends BaseViewModel {
  final WindowSizeService _windowSizeService = locator<WindowSizeService>();
  // final PreferencesService _preferencesService = locator<PreferencesService>();

  // UserChoice get userChoice =>
  //     _preferencesService.getUserChoice() ?? UserChoice.defaultChoice();
  // Future<void> setUserChoicePersist(UserChoice newUserChoice) async {
  //   await _preferencesService.saveUserChoice(userChoice);
  // }

  Future<void> initializeWindowSize() async {
    await _windowSizeService.initialize();
  }

  Future<void> fakeDelay({int seconds}) async {
    await Future.delayed(
      Duration(
        seconds: seconds ?? 1,
      ),
    );
  }
}
