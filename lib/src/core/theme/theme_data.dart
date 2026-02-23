import 'package:flutter/material.dart';
import 'app_theme.dart';

// Фабрика для преобразования AppTheme в ThemeData Flutter
class ThemeDataFactory {
  static ThemeData fromAppTheme(AppTheme theme) {
    // Список со всеми темами
    switch (theme.type) {
      // Тёмная тема
      case AppThemeMode.dark:
        return ThemeData(
          brightness: Brightness.dark,  // акцент темы
          primaryColor: theme.primaryColor, // основной цвет
          colorScheme: ColorScheme.dark(
            secondary: theme.accentColor, // вторичный цвет
            surface: theme.backgroundColor, // цвет фона
          ),
        );

      // Светлая тема
      case AppThemeMode.light:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: theme.primaryColor,
          colorScheme: ColorScheme.light(
            secondary: theme.accentColor,
            surface: theme.backgroundColor,
          ),
        );
    }
  }
}