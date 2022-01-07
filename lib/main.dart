import 'package:bitsdojo_window/bitsdojo_window.dart' as bitsdojo_window;
import 'package:flutter/material.dart';
import 'package:flutter_installer/core/fi_app.dart';
import 'package:flutter_installer/core/utils/fi_logger.dart';

void main() {
  FiLogger.initLogger();

  runApp(
    const FiApp(),
  );

  bitsdojo_window.doWhenWindowReady(() {
    /// In case you want to change this, make sure it is a 16:9 ratio.
    /// This will make sure the size will increase but nothing will break,
    /// hopefully :).
    const Size initialSize = Size(720, 405);
    bitsdojo_window.appWindow.minSize = initialSize;
    bitsdojo_window.appWindow.size = initialSize;
    bitsdojo_window.appWindow.maxSize = initialSize;
    bitsdojo_window.appWindow.alignment = Alignment.center;
    bitsdojo_window.appWindow.show();
  });
}
