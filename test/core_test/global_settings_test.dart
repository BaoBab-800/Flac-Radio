import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';

void main() {
  group('GlobalSettings', () {
    test('Defaults are correct', () {
      expect(GlobalSettings.defaults.localeCode, 'en');
      expect(GlobalSettings.defaults.themeMode, AppThemeMode.light);
    });

    test('CopyWith updates fields correctly', () {
      final settings = GlobalSettings.defaults;
      final updated = settings.copyWith(localeCode: 'fr', themeMode: AppThemeMode.dark);

      expect(updated.localeCode, 'fr');
      expect(updated.themeMode, AppThemeMode.dark);

      expect(settings.localeCode, 'en');
      expect(settings.themeMode, AppThemeMode.light);
    });

    test('ToJson and fromJson roundtrip', () {
      final settings = GlobalSettings.defaults;
      final json = settings.toJson();
      final restored = GlobalSettings.fromJson(json);

      expect(restored.localeCode, settings.localeCode);
      expect(restored.themeMode, settings.themeMode);
    });

    test('FromJson handles missing fields', () {
      final restored = GlobalSettings.fromJson({});
      expect(restored.localeCode, 'en');
      expect(restored.themeMode, AppThemeMode.light);
    });

    test('FromJson handles null themeMode', () {
      final restored = GlobalSettings.fromJson({'localeCode': 'uk', 'themeMode': null});
      expect(restored.localeCode, 'uk');
      expect(restored.themeMode, AppThemeMode.light);
    });
  });
}