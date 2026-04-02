import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';
import 'package:musicplayer/src/services/settings/background_playback_policy.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:test/test.dart';

class _FakeSettingsRepository implements SettingsRepository {
  @override
  Future<SettingsDto> load() async => const SettingsDto(
    global: GlobalSettings(
      localeCode: 'en',
      themeMode: AppThemeMode.light,
    ),
    player: PlayerSettings(
      stopOnBackground: false,
      volume: 1,
    ),
  );

  @override
  Future<void> reset() async {}

  @override
  Future<void> save(SettingsDto settings) async {}
}

void main() {
  group('SettingsBackgroundPlaybackPolicy', () {
    late SettingsService settingsService;
    late SettingsBackgroundPlaybackPolicy policy;

    setUp(() {
      settingsService = SettingsService(_FakeSettingsRepository());
      policy = SettingsBackgroundPlaybackPolicy(settingsService);
    });

    test('returns false when stopOnBackground is disabled', () {
      expect(policy.shouldStopOnPaused(), false);
    });

    test('returns true when stopOnBackground is enabled', () async {
      await settingsService.updatePlayer(
        const PlayerSettings(stopOnBackground: true, volume: 1),
      );

      expect(policy.shouldStopOnPaused(), true);
    });
  });
}