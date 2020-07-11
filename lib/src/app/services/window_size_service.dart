import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'package:window_size/window_size.dart';

@injectable
class WindowSizeService {
  static const double width = 800;
  static const double height = 500;

  Future<PlatformWindow> _getPlatformWindow() async {
    return await window_size.getWindowInfo();
  }

  void _setWindowSize(PlatformWindow platformWindow) {
    final Rect frame = Rect.fromCenter(
      center: Offset(
        platformWindow.frame.center.dx,
        platformWindow.frame.center.dy,
      ),
      width: width,
      height: height,
    );

    window_size.setWindowFrame(frame);

    setWindowTitle(
      'Flutter Installer for ${Platform.operatingSystem}',
    );

    if (Platform.isMacOS) {
      window_size.setWindowMinSize(Size(width, height));
      window_size.setWindowMaxSize(Size(width * 2, height * 2));
    }
  }

  Future<void> initialize() async {
    PlatformWindow platformWindow = await _getPlatformWindow();

    if (platformWindow.screen != null) {
      if (platformWindow.screen.visibleFrame.width != 800 ||
          platformWindow.screen.visibleFrame.height != 500) {
        _setWindowSize(platformWindow);
      }
    }
  }

  void setWindowTitle(String title) {
    window_size.setWindowTitle(title);
  }
}
