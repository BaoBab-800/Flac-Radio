import 'package:flutter/material.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  AppThemes хранит и предоставляет конфигурации тем приложения
  1. Определяет коллекцию доступных тем по AppThemeMode
  2. Предоставляет метод получения темы с fallback на светлую
  3. Расширение AppThemeModeX возвращает локализованную метку темы
*/

class AppThemes {
  // Коллекция всех тем по типу
  static final Map<AppThemeMode, AppTheme> all = {
    AppThemeMode.dark: AppTheme(
      type: AppThemeMode.dark,
      primaryColor: Colors.blue[300]!,
      accentColor: Colors.white,
      backgroundColor: Color(0xFF0F0F0F),
    ),
    AppThemeMode.light: AppTheme(
      type: AppThemeMode.light,
      primaryColor: Colors.blue[300]!,
      accentColor: Colors.white,
      backgroundColor: Colors.white,
    ),
  };

  // Получение темы по типу с fallback на светлую
  static AppTheme byType(AppThemeMode type) => all[type] ?? all[AppThemeMode.light]!;
}

// Получение локализованной метки темы
extension AppThemeModeX on AppThemeMode {
  String label(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case AppThemeMode.light:
        return l10n.themeLight;
      case AppThemeMode.dark:
        return l10n.themeDark;
    }
  }
}