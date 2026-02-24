import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_colors.dart';

class ThemeDataFactory {
  // Создание ThemeData на основе переданной темы приложения
  static ThemeData fromAppTheme(AppTheme theme) {
    // Инициализация объекта AppColors для хранения основных цветов темы
    final colors = AppColors(
      primary: theme.primaryColor,
      accent: theme.accentColor,
      background: theme.backgroundColor,
      onBackground: theme.type == AppThemeMode.dark
          ? Color(0xFF171717)
          : Color(0xFFF2F2F2),
    );

    return ThemeData(
      // Установка яркости темы в зависимости от типа темы (светлая или тёмная)
      brightness: theme.type == AppThemeMode.dark ? Brightness.dark : Brightness.light,
      // Основной цвет приложения
      primaryColor: theme.primaryColor,
      // Настройка схемы цветов с учётом типа темы
      colorScheme: theme.type == AppThemeMode.dark
          ? ColorScheme.dark(
        secondary: theme.accentColor,
        surface: theme.backgroundColor,
      )
          : ColorScheme.light(
        secondary: theme.accentColor,
        surface: theme.backgroundColor,
      ),
      // Добавление расширений с дополнительными цветами для темы
      extensions: [colors],
    );
  }
}