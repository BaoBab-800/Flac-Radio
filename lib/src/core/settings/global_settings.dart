import 'package:musicplayer/src/core/theme/app_theme.dart';

/*
  Общая идея:
  GlobalSettings хранит глобальные настройки приложения
  1. Управляет темой приложения через ThemeMode
  2. Управляет локалью приложения через localeCode
  3. Предоставляет методы для копирования с изменениями (copyWith)
  4. Поддерживает сериализацию в JSON и восстановление из JSON
  5. Определяет значения по умолчанию через defaults
*/

class GlobalSettings {
  final String localeCode;
  final AppThemeMode themeMode;

  // Конструктор с обязательными параметрами
  const GlobalSettings({
    required this.localeCode,
    required this.themeMode,
  });

  // Значения по умолчанию для глобальных настроек
  static const defaults = GlobalSettings(
    localeCode: 'en',
    themeMode: AppThemeMode.light,
  );

  // Создание копии объекта с выборочным изменением полей
  GlobalSettings copyWith({
    String? localeCode,
    AppThemeMode? themeMode,
  }) {
    return GlobalSettings(
      localeCode: localeCode ?? this.localeCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  // Сериализация глобальных настроек в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'localeCode': localeCode,
      'themeMode': themeMode.index,
    };
  }

  // Восстановление глобальных настроек из Map (JSON)
  factory GlobalSettings.fromJson(Map<String, dynamic> json) {
    return GlobalSettings(
      localeCode: json['localeCode'] as String? ?? defaults.localeCode,
      themeMode: AppThemeMode.values[(json['themeMode'] as int?) ?? defaults.themeMode.index],
    );
  }
}