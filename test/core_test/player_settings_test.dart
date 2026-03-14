import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';

void main() {
  group('PlayerSettings', () {
    test('defaults are correct', () {
      expect(PlayerSettings.defaults.stopOnBackground, false);
      expect(PlayerSettings.defaults.volume, 1.0);
    });

    test('copyWith updates fields correctly', () {
      final settings = PlayerSettings.defaults;
      final updated = settings.copyWith(stopOnBackground: true, volume: 0.5);

      expect(updated.stopOnBackground, true);
      expect(updated.volume, 0.5);

      expect(settings.stopOnBackground, false);
      expect(settings.volume, 1.0);
    });

    test('toJson and fromJson roundtrip', () {
      final settings = PlayerSettings(stopOnBackground: true, volume: 0.7);
      final json = settings.toJson();
      final restored = PlayerSettings.fromJson(json);

      expect(restored.stopOnBackground, settings.stopOnBackground);
      expect(restored.volume, settings.volume);
    });

    test('fromJson handles missing fields', () {
      final restored = PlayerSettings.fromJson({});
      expect(restored.stopOnBackground, false);
      expect(restored.volume, 1.0);
    });

    test('fromJson normalizes volume correctly', () {
      final overVolume = PlayerSettings.fromJson({'volume': 2.0});
      final underVolume = PlayerSettings.fromJson({'volume': -1.0});
      final validVolume = PlayerSettings.fromJson({'volume': 0.6});

      expect(overVolume.volume, 1.0);
      expect(underVolume.volume, 0.0);
      expect(validVolume.volume, 0.6);
    });

    test('fromJson handles non-numeric volume gracefully', () {
      final settings = PlayerSettings.fromJson({'volume': 'abc'});
      expect(settings.volume, 1.0);
    });

    test('fromJson handles null stopOnBackground', () {
      final settings = PlayerSettings.fromJson({'stopOnBackground': null});
      expect(settings.stopOnBackground, false);
    });
  });
}