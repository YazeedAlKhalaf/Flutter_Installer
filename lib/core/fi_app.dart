import 'package:flutter/material.dart';
import 'package:flutter_installer/core/fi_window_border.dart';
import 'package:flutter_installer/home/home_screen.dart';

class FIApp extends StatelessWidget {
  const FIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      builder: (BuildContext context, Widget? child) {
        return FLWindowBorder(child: child!);
      },
    );
  }
}
