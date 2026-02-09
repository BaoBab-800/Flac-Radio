import 'package:flutter/material.dart';

import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  ThemeService синхронизирует ThemeMode приложения с глобальными настройками
  1. Хранит текущий ThemeMode в памяти
  2. Позволяет менять тему через setThemeMode и сохраняет изменения в SettingsService
  3. Отслеживает изменения глобальных настроек и обновляет ThemeMode автоматически
  4. Уведомляет UI об изменениях через ChangeNotifier
*/

class ThemeController extends ChangeNotifier {
  // Сервис настроек приложения для синхронизации темы
  final SettingsService _settingsService;

  // Текущий ThemeMode в памяти
  ThemeMode _themeMode;

  // Конструктор с синхронизацией начального состояния и подпиской на изменения настроек
  ThemeController(this._settingsService)
      : _themeMode = _settingsService.global.themeMode {
    _settingsService.addListener(_handleSettingsChanged);
  }

  // Доступ к текущему ThemeMode для UI
  ThemeMode get themeMode => _themeMode;

  // Установка нового ThemeMode и сохранение в SettingsService
  Future<void> setThemeMode(ThemeMode mode) async {
    // Защита от повторной установки той же темы
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners(); // уведомление UI

    // Обновление глобальных настроек приложения
    await _settingsService.updateGlobal(
      _settingsService.global.copyWith(themeMode: mode),
    );
  }

  // Обработка изменений глобальных настроек
  void _handleSettingsChanged() {
    final nextMode = _settingsService.global.themeMode;

    // Если тема не изменилась, не делать лишних обновлений
    if (_themeMode == nextMode) return;

    _themeMode = nextMode;
    notifyListeners(); // уведомление UI о смене темы
  }

  @override
  void dispose() {
    // Отписка от изменений настроек при уничтожении ThemeService
    _settingsService.removeListener(_handleSettingsChanged);
    super.dispose();
  }
}