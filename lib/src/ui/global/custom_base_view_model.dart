import 'package:stacked/stacked.dart';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';

class CustomBaseViewModel extends BaseViewModel {
  final WindowSizeService _windowSizeService = locator<WindowSizeService>();
  final Utils _utils = locator<Utils>();

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

  Future<void> launchUrl(String url) async {
    await _utils.launchUrl(url);
  }
}
