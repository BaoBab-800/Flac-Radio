import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'audio_player_state.dart';
import 'player_stream_observer.dart';
import 'station_playlist_controller.dart';
import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

/*
  Общая идея:
  PlayerService управляет сценариями управления плеером.
  1. Делегирует синхронизацию стримов PlayerStreamObserver
  2. Делегирует навигацию по станциям StationPlaylistController
  3. Содержит сценарии play/pause/stop/toggle и эмит состояния
*/

class PlayerService extends ChangeNotifier {
  static bool backgroundAudioEnabled = true;

  final AudioPlayer _audioPlayer;
  final StationPlaylistController _playlist = StationPlaylistController();
  late final PlayerStreamObserver _streamObserver;

  Map<String, String> _localizedTitlesByKey = const {};

  PlayerService(this._audioPlayer) {
    _streamObserver = PlayerStreamObserver(
      _audioPlayer,
      readState: () => _state,
      emit: _emit,
    )..start();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  AudioPlayerState get state => _state;

  AudioPlayerState _state = AudioPlayerState.empty;

  List<RadioStation> get stations => _playlist.stations;
  set stations(List<RadioStation> value) => _playlist.stations = value;

  int get currentIndex => _playlist.currentIndex;
  set currentIndex(int index) => _playlist.setCurrentIndex(index);

  // Обновление состояния и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  @visibleForTesting
  void setCurrentStationForTest(RadioStation station) {
    _state = _state.copyWith(currentStation: station);
  }

  // Запуск воспроизведения станции
  Future<void> play(
      RadioStation station, {
        String? localizedTitle,
        Map<String, String>? localizedTitlesByKey,
      }) async {
    if (localizedTitlesByKey != null) _localizedTitlesByKey = localizedTitlesByKey;

    // Повторный запуск уже играющей станции
    if (_state.currentStation?.id == station.id && _audioPlayer.playing) return;

    // Продолжение воспроизведения текущей станции
    if (_state.currentStation?.id == station.id && !_audioPlayer.playing) {
      await _audioPlayer.play();
      return;
    }

    _playlist.syncCurrentIndexWith(station);

    // Установка текущей станции до загрузки потока
    _emit(
      _state.copyWith(
        currentStation: station,
        error: null,
      ),
    );

    try {
      // Установка плейлиста и запуск воспроизведения
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: [
            _stationSource(
              station,
              localizedTitle: _localizedTitlesByKey[station.titleKey] ??
                  localizedTitle ??
                  station.titleKey,
            ),
          ],
        ),
        initialIndex: 0,
      );

      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Playback start error');

      // Обработка ошибки запуска
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          error: AppError.playbackStart,
        ),
      );
    }
  }

  // Установщик url
  AudioSource _stationSource(
      RadioStation station, {
        required String localizedTitle,
      }) {
    return AudioSource.uri(
      station.streamUrl,
      tag: backgroundAudioEnabled
          ? MediaItem(
        id: station.id,
        title: localizedTitle,
      ) : null,
    );
  }

  // Пауза воспроизведения
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Переключение состояния воспроизведения
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) await _audioPlayer.pause();
      else await _audioPlayer.play();
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      _emit(
        _state.copyWith(
          error: AppError.playbackControl,
        ),
      );
    }
  }

  // Полная остановка и сброс состояния
  Future<void> stop() async {
    await _audioPlayer.stop();
    _emit(AudioPlayerState.empty);
  }

  // Изменение громкости
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    _emit(_state.copyWith(volume: volume));
  }

  // Переключение на следующую станцию
  Future<void> nextStation() async {
    final station = _playlist.next();
    if (station == null) return;

    await play(station);
  }

  // Переключение на предыдущую станцию
  Future<void> previousStation() async {
    final station = _playlist.previous();
    if (station == null) return;

    await play(station);
  }

  // Освобождение ресурсов
  @override
  void dispose() {
    _streamObserver.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}