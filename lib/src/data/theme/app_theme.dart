import 'package:flutter/material.dart';

// Список цветовых акцентов темы
enum AppThemeColor {
  red,
  green,
  blue,
  deepPurple,
  orange,
}

// Фабрика темы
class AppThemes {
  static ThemeData fromSettings(ThemeMode mode, AppThemeColor color) {
    // Мапинг цветов из enum
    final seedColor = switch (color) {
      AppThemeColor.red => Colors.red,
      AppThemeColor.green => Colors.green,
      AppThemeColor.blue => Colors.blue,
      AppThemeColor.deepPurple => Colors.deepPurple,
      AppThemeColor.orange => Colors.orange,
    };

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      ),
    );
  }

  static const availableColors = AppThemeColor.values;
}