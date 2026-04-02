import 'package:musicplayer/src/services/settings/settings_service.dart';

// Политика, определяющая поведение плеера при уходе приложения в фон.
abstract class BackgroundPlaybackPolicy {
  bool shouldStopOnPaused();
}

// Реализация политики на основе пользовательских настроек.
class SettingsBackgroundPlaybackPolicy implements BackgroundPlaybackPolicy {
  final SettingsService _settingsService;

  SettingsBackgroundPlaybackPolicy(this._settingsService);

  @override
  bool shouldStopOnPaused() {
    return _settingsService.player.stopOnBackground;
  }
}