import 'package:flutter/material.dart';
import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/services/theme/theme_controller.dart';
import 'package:test/test.dart';

// Репозиторий без реальных функций
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository({required this.loadedSettings});

  SettingsDto loadedSettings;
  SettingsDto? savedSettings;
  int saveCalls = 0;
  int loadCalls = 0;

  @override
  Future<SettingsDto> load() async {
    loadCalls++;
    return loadedSettings;
  }

  @override
  Future<void> save(SettingsDto settings) async {
    saveCalls++;
    savedSettings = settings;
  }

  @override
  Future<void> reset() async {}
}

void main() {
  group('ThemeController', () {
    late FakeSettingsRepository repository;
    late SettingsService settingsService;
    late ThemeController controller;

    setUp(() async {
      repository = FakeSettingsRepository(
        loadedSettings: const SettingsDto(
          global: GlobalSettings(
            localeCode: 'en',
            themeMode: AppThemeMode.dark,
          ),
          player: PlayerSettings.defaults,
        ),
      );

      settingsService = SettingsService(repository);
      await settingsService.init();
      controller = ThemeController(settingsService);
    });

    tearDown(() {
      controller.dispose();
    });

    test('Reads initial theme from SettingsService', () {
      expect(controller.themeMode, AppThemeMode.dark);
      expect(controller.flutterThemeMode, ThemeMode.dark);
    });

    test('Maps light theme to Flutter ThemeMode.light', () async {
      await settingsService.updateGlobal(const GlobalSettings(
        localeCode: 'en',
        themeMode: AppThemeMode.light,
      ));

      expect(controller.themeMode, AppThemeMode.light);
      expect(controller.flutterThemeMode, ThemeMode.light);
    });

    test('ToggleTheme switches back when called twice', () async {
      await controller.toggleTheme();
      await controller.toggleTheme();

      expect(controller.themeMode, AppThemeMode.dark);
    });

    test('ToggleTheme switches mode, notifies and persists in settings', () async {
      var notifications = 0;
      controller.addListener(() => notifications++);

      await controller.toggleTheme();

      expect(controller.themeMode, AppThemeMode.light);
      expect(controller.flutterThemeMode, ThemeMode.light);
      expect(settingsService.global.themeMode, AppThemeMode.light);
      expect(repository.saveCalls, 1);
      expect(repository.savedSettings?.global.themeMode, AppThemeMode.light);
      expect(notifications, 1);
    });

    test('Reacts to external settings changes', () async {
      var notifications = 0;
      controller.addListener(() => notifications++);

      await settingsService.updateGlobal(const GlobalSettings(
        localeCode: 'en',
        themeMode: AppThemeMode.light,
      ));

      expect(controller.themeMode, AppThemeMode.light);
      expect(notifications, 1);
    });

    test('Does not notify when settings changed but theme is same', () async {
      var notifications = 0;
      controller.addListener(() => notifications++);

      await settingsService.updateGlobal(const GlobalSettings(
        localeCode: 'ru',
        themeMode: AppThemeMode.dark,
      ));

      expect(controller.themeMode, AppThemeMode.dark);
      expect(notifications, 0);
    });
  });
}