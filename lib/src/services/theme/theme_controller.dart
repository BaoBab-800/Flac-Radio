import 'package:flutter/material.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';

/*
  Общая идея:
  ThemeController управляет текущей темой приложения
  1. Хранит состояние темы в _themeMode
  2. Слушает изменения глобальных настроек через SettingsService
  3. Позволяет переключать тему и сохранять выбор пользователя
  4. Уведомляет слушателей о смене темы через ChangeNotifier
*/

class ThemeController extends ChangeNotifier {
  final SettingsService _settingsService;
  AppThemeMode _themeMode;

  // Инициализация с текущей темой из глобальных настроек и подписка на изменения
  ThemeController(this._settingsService)
      : _themeMode = _settingsService.global.themeMode {
    _settingsService.addListener(_handleSettingsChanged);
  }

  // Текущий режим темы
  AppThemeMode get themeMode => _themeMode;

  // Преобразование темы в ThemeMode для Flutter
  ThemeMode get flutterThemeMode => _themeMode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;

  // Переключение темы между светлой и тёмной и сохранение в настройках
  Future<void> toggleTheme() async {
    final newMode = _themeMode == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;

    _themeMode = newMode;
    notifyListeners();

    // Сохранение нового режима темы в глобальные настройки
    await _settingsService.updateGlobal(
      _settingsService.global.copyWith(themeMode: newMode),
    );
  }

  // Синхронизация локального состояния с глобальными настройками
  void _handleSettingsChanged() {
    final nextMode = _settingsService.global.themeMode;
    if (_themeMode == nextMode) return;

    _themeMode = nextMode;
    notifyListeners();
  }

  // Очистка подписки при уничтожении контроллера
  @override
  void dispose() {
    _settingsService.removeListener(_handleSettingsChanged);
    super.dispose();
  }
}