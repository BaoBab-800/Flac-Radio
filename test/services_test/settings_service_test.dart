import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

// Репозиторий без реальных функций
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository({required this.loadedSettings});

  SettingsDto loadedSettings;
  SettingsDto? savedSettings;
  int saveCalls = 0;
  int resetCalls = 0;
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
  Future<void> reset() async {
    resetCalls++;
  }
}

void main() {
  group('SettingsService', () {
    late FakeSettingsRepository repository;
    late SettingsService service;

    setUp(() {
      repository = FakeSettingsRepository(
        loadedSettings: const SettingsDto(
          global: GlobalSettings(
            localeCode: 'ru',
            themeMode: AppThemeMode.dark,
          ),

          player: PlayerSettings(
            stopOnBackground: true,
            volume: 0.4,
          ),
        ),
      );

      service = SettingsService(repository);
    });

    // Значения по умолчанию
    test('Has defaults before initialization', () {
      expect(service.state, SettingsDto.defaults);
      expect(service.global.localeCode, 'en');
      expect(service.player.volume, 1.0);
    });

    // Тест всего жизненного цикла init
    test('Init loads settings and notifies listeners', () async {
      var notifications = 0;
      service.addListener(() => notifications++);

      await service.init();

      expect(repository.loadCalls, 1);
      expect(service.global.localeCode, 'ru');
      expect(service.global.themeMode, AppThemeMode.dark);
      expect(service.player.stopOnBackground, true);
      expect(service.player.volume, 0.4);
      expect(notifications, 1);
    });

    test('UpdateGlobal updates state, saves and notifies listeners', () async {
      var notifications = 0;
      service.addListener(() => notifications++);

      const nextGlobal = GlobalSettings(
        localeCode: 'fr',
        themeMode: AppThemeMode.dark,
      );

      await service.updateGlobal(nextGlobal);

      expect(service.global, nextGlobal);
      expect(repository.saveCalls, 1);
      expect(repository.savedSettings?.global, nextGlobal);
      expect(repository.savedSettings?.player, SettingsDto.defaults.player);
      expect(notifications, 1);
    });

    test('UpdatePlayer updates state, saves and notifies listeners', () async {
      var notifications = 0;
      service.addListener(() => notifications++);

      const nextPlayer = PlayerSettings(
        stopOnBackground: true,
        volume: 0.2,
      );

      await service.updatePlayer(nextPlayer);

      expect(service.player, nextPlayer);
      expect(repository.saveCalls, 1);
      expect(repository.savedSettings?.player, nextPlayer);
      expect(repository.savedSettings?.global, SettingsDto.defaults.global);
      expect(notifications, 1);
    });

    test('SetLocale changes only locale, saves and notifies listeners', () async {
      var notifications = 0;
      service.addListener(() => notifications++);

      await service.updateGlobal(const GlobalSettings(
        localeCode: 'en',
        themeMode: AppThemeMode.dark,
      ));

      await service.setLocale('uk');

      expect(service.global.localeCode, 'uk');
      expect(service.global.themeMode, AppThemeMode.dark);
      expect(repository.saveCalls, 2);
      expect(repository.savedSettings?.global.localeCode, 'uk');
      expect(notifications, 2);
    });

    test('Reset returns defaults and calls repository.reset', () async {
      var notifications = 0;
      service.addListener(() => notifications++);

      await service.reset();

      expect(service.state, SettingsDto.defaults);
      expect(repository.resetCalls, 1);
      expect(notifications, 1);
    });

    test('Reset clears changed settings', () async {
      await service.updateGlobal(const GlobalSettings(
        localeCode: 'fr',
        themeMode: AppThemeMode.dark,
      ));

      await service.reset();

      expect(service.state, SettingsDto.defaults);
    });
  });
}