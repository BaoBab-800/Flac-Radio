import 'package:flutter/material.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';

/*
  Общая идея:
  AppThemes центральный реестр всех тем приложения
  1. Хранит готовые конфигурации AppTheme
  2. Даёт доступ к теме по AppThemeType
  3. Используется ThemeService для восстановления и переключения темы
*/

class AppThemes {
  // Список тем
  static final Map<AppThemeMode, AppTheme> all = {
    // Тёмная
    AppThemeMode.dark: AppTheme(
      type: AppThemeMode.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.orange,
      backgroundColor: Colors.black,
    ),
    // Светлая
    AppThemeMode.light: AppTheme(
      type: AppThemeMode.light,
      primaryColor: Colors.grey,
      accentColor: Colors.redAccent,
      backgroundColor: Colors.white,
    ),
  };

  // Доступ по типу
  static AppTheme byType(AppThemeMode type) {
    return all[type] ?? all[AppThemeMode.light]!;
  }
}