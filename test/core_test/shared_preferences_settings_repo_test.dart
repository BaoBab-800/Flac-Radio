import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:musicplayer/src/data/settings/settings_dto.dart';
import 'package:musicplayer/src/core/settings/shared_prefs_settings_repository.dart';

void main() {
  group('SharedPrefsSettingsRepository', () {
    late SharedPrefsSettingsRepository repo;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repo = const SharedPrefsSettingsRepository();
    });

    test('Load returns defaults if nothing stored', () async {
      final loaded = await repo.load();
      expect(loaded, SettingsDto.defaults);
    });

    test('Save stores settings and load restores them', () async {
      final settings = SettingsDto(
        global: SettingsDto.defaults.global.copyWith(localeCode: 'fr'),
        player: SettingsDto.defaults.player,
      );

      await repo.save(settings);
      final loaded = await repo.load();

      expect(loaded.global.localeCode, 'fr');
      expect(loaded.player.volume, SettingsDto.defaults.player.volume);
    });

    test('Reset removes stored settings', () async {
      final settings = SettingsDto.defaults;
      await repo.save(settings);

      await repo.reset();
      final loaded = await repo.load();

      expect(loaded, SettingsDto.defaults);
    });

    test('Load recovers from malformed JSON', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_settings', 'not json');

      final loaded = await repo.load();

      expect(loaded, SettingsDto.defaults);
    });
  });
}