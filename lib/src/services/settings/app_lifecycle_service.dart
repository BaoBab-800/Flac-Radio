import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'settings_service.dart';

/*
  Общая идея:
  AppLifecycleService наблюдает за жизненным циклом приложения
  1. Слушает смену состояния приложения (foreground/background)
  2. Координирует поведение сервисов при уходе приложения в фон
*/

class AppLifecycleService with WidgetsBindingObserver {
  final PlayerService _player;
  final SettingsService _settings;

  // Регистрация observer при создании сервиса
  AppLifecycleService(this._player, this._settings) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Если приложение уходит в фон и включена опция stopOnBackground
    if (state == AppLifecycleState.paused &&
        _settings.player.stopOnBackground) {
      // Асинхронная остановка плеера без ожидания результата
      unawaited(_player.stop());
    }
  }

  // Удаление observer при уничтожении сервиса
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}