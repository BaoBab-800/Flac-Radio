import 'package:flutter/material.dart';

class Themes {
  Themes._();

  // Тёмная тема
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
        bodySmall: TextStyle(color: Colors.white70),
      ),
    );
  }
}