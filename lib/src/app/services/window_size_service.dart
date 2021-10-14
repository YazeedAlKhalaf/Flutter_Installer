import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

@injectable
class WindowSizeService {
  static const double width = 1200;
  static const double height = 720;

  Future<void> initialize() async {
    doWhenWindowReady(() {
      const initialSize = Size(height, width);
      if (Platform.isMacOS) {
        appWindow.minSize = Size(width, height);
        appWindow.maxSize = Size(width * 2, height * 2);
      } else {
        appWindow.minSize = initialSize;
        appWindow.size = initialSize;
      }
      appWindow.title = 'Flutter Installer for ${Platform.operatingSystem.capitalize()}';
      appWindow.show();
    });
  }
}
