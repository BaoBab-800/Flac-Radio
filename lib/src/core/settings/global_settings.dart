import 'package:musicplayer/src/core/theme/app_theme.dart';

/*
  Общая идея:
  GlobalSettings хранит глобальные настройки приложения
  1. Управляет темой и локалью приложения
  2. Предоставляет методы copyWith для копирования с изменениями
  3. Поддерживает сериализацию в JSON и восстановление из JSON
  4. Определяет значения по умолчанию через defaults
*/

class GlobalSettings {
  final String localeCode;
  final AppThemeMode themeMode;

  const GlobalSettings({
    required this.localeCode,
    required this.themeMode,
  });

  // Значения по умолчанию
  static const defaults = GlobalSettings(
    localeCode: 'en',
    themeMode: AppThemeMode.light,
  );

  // Копия с изменёнными полями
  GlobalSettings copyWith({
    String? localeCode,
    AppThemeMode? themeMode,
  }) {
    return GlobalSettings(
      localeCode: localeCode ?? this.localeCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  // Преобразование в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'localeCode': localeCode,
      'themeMode': themeMode.index,
    };
  }

  // Восстановление из Map
  factory GlobalSettings.fromJson(Map<String, dynamic> json) {
    return GlobalSettings(
      localeCode: json['localeCode'] as String? ?? defaults.localeCode,
      themeMode: AppThemeMode.values[(json['themeMode'] as int?) ?? defaults.themeMode.index],
    );
  }
}