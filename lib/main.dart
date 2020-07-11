import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'package:window_size/window_size.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  window_size.getWindowInfo().then((PlatformWindow window) {
    if (window.screen != null) {
      final double width = 800;
      final double height = 500;
      final Rect frame = Rect.fromCenter(
        center: Offset(
          window.frame.center.dx,
          window.frame.center.dy,
        ),
        width: width,
        height: height,
      );

      window_size.setWindowFrame(frame);

      window_size.setWindowTitle(
        'Flutter Installer for ${Platform.operatingSystem}',
      );

      if (Platform.isMacOS) {
        window_size.setWindowMinSize(Size(width, height));
        window_size.setWindowMaxSize(Size(width * 2, height * 2));
      }
    }
  });

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  // Runs the app :)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
