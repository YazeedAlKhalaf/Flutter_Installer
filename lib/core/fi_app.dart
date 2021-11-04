import 'package:flutter/material.dart';
import 'package:flutter_installer/home/home_screen.dart';

class FIApp extends StatelessWidget {
  const FIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
