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
  static final Map<AppThemeType, AppTheme> all = {
    // Тёмная
    AppThemeType.dark: AppTheme(
      type: AppThemeType.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.orange,
      backgroundColor: Colors.black,
    ),
    // Светлая
    AppThemeType.light: AppTheme(
      type: AppThemeType.light,
      primaryColor: Colors.grey,
      accentColor: Colors.redAccent,
      backgroundColor: Colors.white,
    ),
    // Кастомная
    AppThemeType.custom: AppTheme(
      type: AppThemeType.custom,
      primaryColor: Colors.teal,
      accentColor: Colors.amber,
      backgroundColor: Colors.grey[900]!,
    ),
  };

  // Доступ по типу
  static AppTheme byType(AppThemeType type) {
    return all[type] ?? all[AppThemeType.light]!;
  }
}