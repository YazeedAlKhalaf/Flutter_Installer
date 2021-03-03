import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/app.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  await locator<WindowSizeService>().initialize();

  await locator<LocalStorageService>().initialize();

  // Runs the app :)
  runApp(App());
}
