import 'package:flutter/material.dart';
import 'app_theme.dart';

// фабрика для преобразования AppTheme в ThemeData Flutter
class ThemeDataFactory {
  static ThemeData getThemeData(AppTheme theme) {
    // список со всеми темами
    switch (theme.type) {
      // тёмная тема
      case AppThemeType.dark:
        return ThemeData(
          brightness: Brightness.dark,  // акцент темы
          primaryColor: theme.primaryColor, // основной цвет
          colorScheme: ColorScheme.dark(
            secondary: theme.accentColor, // вторичный цвет
            surface: theme.backgroundColor, // цвет фона
          ),
        );

      // светлая тема
      case AppThemeType.light:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: theme.primaryColor,
          colorScheme: ColorScheme.light(
            secondary: theme.accentColor,
            surface: theme.backgroundColor,
          ),
        );

      // кастомная тема пока использует светлую цветовую схему
      // сюда можно добавить более сложные правила для своих цветов
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