import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/services/shared_prefs/theme_mode_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart'
    as RouterGR;
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class App extends StatelessWidget {
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
          primaryColor: Color(0xff085A9C),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
