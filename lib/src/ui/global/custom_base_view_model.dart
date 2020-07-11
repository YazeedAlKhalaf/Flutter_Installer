import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:stacked/stacked.dart';

class CustomBaseViewModel extends BaseViewModel {
  final WindowSizeService _windowSizeService = locator<WindowSizeService>();

  Future<void> initializeWindowSize() async {
    await _windowSizeService.initialize();
  }
}
