import 'package:flutter/material.dart';

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
  // Текущий режим темы приложения (светлая, тёмная, системная)
  final ThemeMode themeMode;

  // Код локали приложения, например 'en' или 'ru'
  final String localeCode;

  // Конструктор с обязательными параметрами
  const GlobalSettings({
    required this.themeMode,
    required this.localeCode,
  });

  // Значения по умолчанию для глобальных настроек
  static const defaults = GlobalSettings(
    themeMode: ThemeMode.system,
    localeCode: 'en',
  );

  // Создание копии объекта с выборочным изменением полей
  GlobalSettings copyWith({
    ThemeMode? themeMode,
    String? localeCode,
  }) {
    return GlobalSettings(
      themeMode: themeMode ?? this.themeMode,
      localeCode: localeCode ?? this.localeCode,
    );
  }

  // Сериализация глобальных настроек в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
      'localeCode': localeCode,
    };
  }

  // Восстановление глобальных настроек из Map (JSON)
  factory GlobalSettings.fromJson(Map<String, dynamic> json) {
    final themeName = json['themeMode'] as String?;

    return GlobalSettings(
      themeMode: ThemeMode.values.firstWhere(
            (mode) => mode.name == themeName,
        orElse: () => defaults.themeMode,
      ),
      localeCode: json['localeCode'] as String? ?? defaults.localeCode,
    );
  }
}