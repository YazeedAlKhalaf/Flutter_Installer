import 'package:flutter/material.dart';

class FLTheme {
  static const TextTheme _textTheme = TextTheme(
    subtitle1: TextStyle(
      fontFamily: "RobotoMono",
    ),
    subtitle2: TextStyle(
      fontFamily: "RobotoMono",
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: _textTheme,
    fontFamily: 'Roboto',
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: _textTheme,
    fontFamily: 'Roboto',
  );
}
