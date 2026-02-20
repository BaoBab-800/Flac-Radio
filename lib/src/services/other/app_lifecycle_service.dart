import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/services/player/audio_player_state.dart';

class AppLifecycleService with WidgetsBindingObserver {
  // Сервисы плеера и настроек
  final PlayerService _player;
  final AudioPlayerState _playerState;

  // Конструктор регистрирует сервис как наблюдатель жизненного цикла приложения
  AppLifecycleService(this._player, this._playerState) {
    WidgetsBinding.instance.addObserver(this);
  }

  // Просмотр ухода приложения в фон
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Если приложение уходит в фон и в настройках включено останавливать в фоне
    if (state == AppLifecycleState.paused &&
        _playerState.stopOnBackground) {
      // Останавливается плеер
      unawaited(_player.stop());
    }
  }

  // Удаляет observer
  void dispose() { WidgetsBinding.instance.removeObserver(this); }
}