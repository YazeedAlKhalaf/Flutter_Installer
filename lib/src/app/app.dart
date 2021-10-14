import 'package:flutter/material.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/router_service.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    locator<WindowSizeService>().initialize();
    return ThemeModeBuilder(
      builder: (BuildContext context, ThemeMode themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Installer',
          routerDelegate: locator<RouterService>().router.delegate(),
          routeInformationParser: locator<RouterService>().router.defaultRouteParser(),
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xff085A9C),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrangeAccent),
          ),
        );
      },
    );
  }
}
