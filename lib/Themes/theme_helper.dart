import 'package:flutter/material.dart';

// Enum для выбора темы
enum AppThemeOption {
  system,
  light,
  dark,
}

// Функция конвертации AppThemeOption в ThemeMode для MaterialApp
ThemeMode mapThemeMode(AppThemeOption theme) {
  switch (theme) {
    case AppThemeOption.light:
      return ThemeMode.light;
    case AppThemeOption.dark:
      return ThemeMode.dark;
    case AppThemeOption.system:
    default:
      return ThemeMode.system;
  }
}

// Стили приложения для light/dark
class AppThemeData {
  AppThemeData._();

  // Тёмная тема
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
      titleMedium: const TextStyle(fontWeight: FontWeight.w600),
      bodySmall: const TextStyle(color: Colors.white70),
    ),
  );

  // Светлая тема
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
      titleMedium: const TextStyle(fontWeight: FontWeight.w600),
      bodySmall: const TextStyle(color: Colors.black87),
    ),
  );
}