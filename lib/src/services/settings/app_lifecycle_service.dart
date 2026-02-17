import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'settings_service.dart';

/*
  Общая идея:
  1. Слушает изменения жизненного цикла приложения
  2. Координирует поведение сервисов при смене состояния
*/

class AppLifecycleService with WidgetsBindingObserver {
  // Сервисы плеера и настроек
  final PlayerService _player;
  final SettingsService _settings;

  // Конструктор регистрирует сервис как наблюдатель жизненного цикла приложения
  AppLifecycleService(this._player, this._settings) {
    WidgetsBinding.instance.addObserver(this);
  }

  // Просмотр ухода приложения в фон
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Если приложение уходит в фон и в настройках включено останавливать в фоне
    if (state == AppLifecycleState.paused &&
        _settings.player.stopOnBackground) {
      // Останавливается плеер
      unawaited(_player.stop());
    }
  }

  // Удаляет observer
  void dispose() { WidgetsBinding.instance.removeObserver(this); }
}