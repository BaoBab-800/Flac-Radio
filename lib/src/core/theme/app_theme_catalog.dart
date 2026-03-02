import 'package:flutter/material.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

// Колекция и получение тем
class AppThemes {
  // Коллекция всех доступных тем приложения, сгруппированных по типу темы
  static final Map<AppThemeMode, AppTheme> all = {
    // Конфигурация тёмной темы
    AppThemeMode.dark: AppTheme(
      type: AppThemeMode.dark,
      primaryColor: Colors.blue[300]!,
      accentColor: Colors.white,
      backgroundColor: Color(0xFF0F0F0F),
    ),
    // Конфигурация светлой темы
    AppThemeMode.light: AppTheme(
      type: AppThemeMode.light,
      primaryColor: Colors.blue[300]!,
      accentColor: Colors.white,
      backgroundColor: Colors.white,
    ),
  };

  // Получение темы по её типу с fallback на светлую тему,
  // если запрошенный тип отсутствует в коллекции
  static AppTheme byType(AppThemeMode type) =>
      all[type] ?? all[AppThemeMode.light]!;
}

// Помощник для локализации
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