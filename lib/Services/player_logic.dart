import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/data/radio_stations.dart';
import 'package:flutter/foundation.dart';

// Контроллер плеера с автоматическим уведомлением UI
class PlayerController {
  // Встроенный плеер
  final AudioPlayer _player = AudioPlayer();

  // ValueNotifier для текущей станции
  // UI может слушать currentStationNotifier и автоматически обновляться
  final ValueNotifier<RadioStation?> currentStationNotifier = ValueNotifier(null);

  // ValueNotifier для состояния воспроизведения
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  PlayerController() {
    // Подписка на поток состояния плеера
    _player.playerStateStream.listen((state) {
      // Обновление флага воспроизведения и уведомление слушателей
      isPlayingNotifier.value = state.playing;
    });
  }

  // Чтение текущей станции
  RadioStation? get currentStation => currentStationNotifier.value;

  // Проверка, играет ли плеер
  bool get isPlaying => isPlayingNotifier.value;

  // Выбор станции пользователем
  Future<void> selectStation(RadioStation station) async {
    // Если выбрана та же станция - переключение Play/Pause
    if (currentStation == station) {
      await togglePlayPause();
      return;
    }

    // Установка новой станции и уведомление слушателей
    currentStationNotifier.value = station;

    // Подготовка потока и запуск воспроизведения
    await _player.setUrl(station.streamUrl.toString());
    await _player.play();
  }

  // Переключение Play/Pause
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    // isPlayingNotifier автоматически обновится через playerStateStream
  }

  // Полная остановка плеера
  Future<void> stop() async {
    await _player.stop();
    currentStationNotifier.value = null;
  }

  // Освобождение ресурсов плеера
  Future<void> dispose() async {
    await _player.dispose();
    currentStationNotifier.dispose();
    isPlayingNotifier.dispose();
  }
}