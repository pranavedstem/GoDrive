import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueAccent,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
