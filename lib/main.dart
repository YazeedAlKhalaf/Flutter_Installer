import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  await locator<WindowSizeService>().initialize();

  await locator<LocalStorageService>().initialize();

  // Runs the app :)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    locator<WindowSizeService>().initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Installer',
      initialRoute: Routes.startupView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
    );
  }
}
