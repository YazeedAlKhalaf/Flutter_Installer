import 'package:flutter/material.dart';
import 'package:flutter_installer/core/fi_window_border.dart';
import 'package:flutter_installer/core/fl_theme.dart';
import 'package:flutter_installer/faq/faq_screen.dart';
import 'package:flutter_installer/home/home_screen.dart';

class FIApp extends StatelessWidget {
  const FIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FLTheme.lightTheme,
      home: const FaqScreen(),
      builder: (BuildContext context, Widget? child) {
        return FLWindowBorder(child: child!);
      },
    );
  }
}
