import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/services/shared_prefs/theme_mode_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart'
    as RouterGR;
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

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
    return ThemeModeHandler(
      manager: ThemeModeService(),
      builder: (ThemeMode themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Installer',
        initialRoute: RouterGR.Routes.startupView,
        onGenerateRoute: RouterGR.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        themeMode: themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
