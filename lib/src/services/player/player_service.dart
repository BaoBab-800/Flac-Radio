import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_player_state.dart';
import 'package:musicplayer/src/data/radio/radio_station_model.dart';

class PlayerService extends ChangeNotifier {
  final AudioPlayer _audioPlayer; // Создание объекта который наследуется от just_audio

  PlayerService(this._audioPlayer) {
    _listenToPlayer();
  }

  AudioPlayerState _state = AudioPlayerState.empty;
  AudioPlayerState get state => _state;

  // Функция обновления состояния
  void _emit(AudioPlayerState newState) {
    if (_state == newState) return; // Если состояние осталось прежним - ничего не делать
    _state = newState;
    notifyListeners();
  }

  // Подписка и обработка стриа аудио
  void _listenToPlayer() {
    // Подписка на стрим
    _audioPlayer.playerStateStream.listen((playerState) {
      // Данные стрима
      final isPlaying = playerState.playing;  // Проигрывается ли
      final processingState = playerState.processingState;  // Фаза потока (loading, buffering, ready, completed)
      final isLoading = processingState == ProcessingState.loading
          || processingState == ProcessingState.buffering; // Загружается ли? В случае загрузки или буферезации стрима - да

      // Обработка завершения потока
      if (processingState == ProcessingState.completed) {
        _emit(_state.copyWith(isPlaying: false, isLoading: false));
        return;
      }

      _emit(_state.copyWith(isPlaying: isPlaying, isLoading: isLoading));
    });
  }

  // Запуск плеера
  Future<void> play(RadioStationModel station) async {
    // Если станция переданая в функцию совпадает с текущей станцией и плеер не запущен - запустить плеер
    if (_state.currentStation?.id == station.id) {
      if (!_audioPlayer.playing) await _audioPlayer.play();
      return;
    }

    _emit(_state.copyWith(currentStation: station));

    // Установка аудио с подставкой агента (по тому что без агента не получается, я всё пробовал)
    await _audioPlayer.setAudioSource(AudioSource.uri(
      station.streamUrl,
      headers: {
        "User-Agent": "Mozilla/5.0 (Android)",
        "Accept": "*/*",
        "Connection": "keep-alive",
      },
    ));

    // Непосредственно запуск
    await _audioPlayer.play();
  }

  // Переключение пауза/плей
  Future<void> togglePlayPause() async {
    if (_audioPlayer.playing) await _audioPlayer.pause();
    else await _audioPlayer.play();
  }

  // Остановка плеера
  Future<void> stop() async {
    await _audioPlayer.stop();
    _emit(AudioPlayerState.empty);
  }

  // Установка громкости
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    _emit(_state.copyWith(volume: volume));
  }

  // Очистка ресурсов плеера
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}