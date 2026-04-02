import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'background_playback_policy.dart';

/*
  Общая идея:
  AppLifecycleService наблюдает за жизненным циклом приложения
  1. Слушает смену состояния приложения (foreground/background)
  2. Координирует поведение сервисов при уходе приложения в фон
*/

class AppLifecycleService with WidgetsBindingObserver {
  final PlayerService _player;
  final BackgroundPlaybackPolicy _backgroundPlaybackPolicy;

  // Регистрация observer при создании сервиса
  AppLifecycleService(this._player, this._backgroundPlaybackPolicy) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused &&
        _backgroundPlaybackPolicy.shouldStopOnPaused()) {
      unawaited(_player.stop());
    }
  }

  // Удаление observer при уничтожении сервиса
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}