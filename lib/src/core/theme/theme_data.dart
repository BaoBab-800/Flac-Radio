import 'package:flutter/material.dart';
import 'app_theme.dart';

// Фабрика для преобразования AppTheme в ThemeData Flutter
class ThemeDataFactory {
  static ThemeData fromAppTheme(AppTheme theme) {
    // Список со всеми темами
    switch (theme.type) {
      // Тёмная тема
      case AppThemeType.dark:
        return ThemeData(
          brightness: Brightness.dark,  // акцент темы
          primaryColor: theme.primaryColor, // основной цвет
          colorScheme: ColorScheme.dark(
            secondary: theme.accentColor, // вторичный цвет
            surface: theme.backgroundColor, // цвет фона
          ),
        );

      // Светлая тема
      case AppThemeType.light:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: theme.primaryColor,
          colorScheme: ColorScheme.light(
            secondary: theme.accentColor,
            surface: theme.backgroundColor,
          ),
        );

      // Кастомная тема пока использует светлую цветовую схему
      // Сюда можно добавить более сложные правила для своих цветов
      case AppThemeType.custom:
        return ThemeData(
          brightness: Brightness.dark,
          primaryColor: theme.primaryColor,
          colorScheme: ColorScheme.light(
            secondary: theme.accentColor,
            surface: theme.backgroundColor,
          ),
        );
    }
  }
}