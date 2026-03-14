import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';

void main() {
  group('SettingsDto', () {
    test('defaults are correct', () {
      expect(SettingsDto.defaults.global, GlobalSettings.defaults);
      expect(SettingsDto.defaults.player, PlayerSettings.defaults);
    });

    test('copyWith updates fields correctly', () {
      final dto = SettingsDto.defaults;

      final updated = dto.copyWith(
        global: dto.global.copyWith(localeCode: 'fr'),
      );

      expect(updated.global.localeCode, 'fr');
      expect(updated.player, dto.player);

      // исходный объект не изменился
      expect(dto.global.localeCode, 'en');
    });

    test('toJson and fromJson roundtrip', () {
      final dto = SettingsDto(
        global: const GlobalSettings(
          localeCode: 'uk',
          themeMode: AppThemeMode.dark,
        ),
        player: const PlayerSettings(
          stopOnBackground: true,
          volume: 0.5,
        ),
      );

      final json = dto.toJson();
      final restored = SettingsDto.fromJson(json);

      expect(restored.global.localeCode, 'uk');
      expect(restored.global.themeMode, AppThemeMode.dark);
      expect(restored.player.stopOnBackground, true);
      expect(restored.player.volume, 0.5);
    });

    test('fromJson handles missing sections', () {
      final dto = SettingsDto.fromJson({});

      expect(dto.global, GlobalSettings.defaults);
      expect(dto.player, PlayerSettings.defaults);
    });

    test('fromJson handles invalid json sections', () {
      final dto = SettingsDto.fromJson({
        'global': 'wrong',
        'player': 123,
      });

      expect(dto.global, GlobalSettings.defaults);
      expect(dto.player, PlayerSettings.defaults);
    });
  });
}