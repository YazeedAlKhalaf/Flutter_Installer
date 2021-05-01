import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

import 'package:flutter_installer/src/app/app.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  /// initialize theme mode builder
  await ThemeModeBuilderConfig.ensureInitialized();

  await locator<WindowSizeService>().initialize();

  await locator<LocalStorageService>().initialize();

  // Runs the app :)
  runApp(App());
}
