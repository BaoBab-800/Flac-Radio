import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_colors.dart';

/*
  Общая идея:
  ThemeDataFactory создаёт ThemeData на основе AppTheme
  1. Настраивает яркость, primaryColor и ColorScheme
  2. Добавляет расширение AppColors с дополнительными цветами
  3. Определяет цвет onBackground в зависимости от типа темы
*/

class ThemeDataFactory {
  static ThemeData fromAppTheme(AppTheme theme) {
    final colors = AppColors(
      primary: theme.primaryColor,
      accent: theme.accentColor,
      background: theme.backgroundColor,
      onBackground: theme.type == AppThemeMode.dark
          ? Color(0xFF171717)
          : Color(0xFFF2F2F2),
    );

    return ThemeData(
      brightness: theme.type == AppThemeMode.dark ? Brightness.dark : Brightness.light,
      primaryColor: theme.primaryColor,

      colorScheme: theme.type == AppThemeMode.dark
          ? ColorScheme.dark(
        secondary: theme.accentColor,
        surface: theme.backgroundColor,
      ) : ColorScheme.light(
        secondary: theme.accentColor,
        surface: theme.backgroundColor,
      ),

      extensions: [colors],
    );
  }
}