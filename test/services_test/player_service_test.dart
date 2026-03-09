import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/services/player/audio_player_state.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:just_audio/just_audio.dart';

import 'package:musicplayer/src/services/player/player_service.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockAudioPlayer mockAudioPlayer;
  late PlayerService service;

  // Станции
  final station1 = RadioStation(
    id: '1',
    titleKey: 'Test1',
    streamUrl: Uri.parse('https://test.com'),
  );

  final station2 = RadioStation(
    id: '2',
    titleKey: 'Test2',
    streamUrl: Uri.parse('https://test.com'),
  );

  final station3 = RadioStation(
    id: '3',
    titleKey: 'Test3',
    streamUrl: Uri.parse('https://test.com'),
  );

  // Общая подготовка
  setUpAll(() {
    registerFallbackValue(
      AudioSource.uri(Uri.parse('https://example.com')),
    );
  });

  // Подготовка окружения
  setUp(() {
    mockAudioPlayer = MockAudioPlayer();

    // Плей
    when(() => mockAudioPlayer.play())
        .thenAnswer((_) async {});

    // Пауза
    when(() => mockAudioPlayer.pause())
        .thenAnswer((_) async {});

    // Стоп
    when(() => mockAudioPlayer.stop())
        .thenAnswer((_) async {});

    // Установка источника аудио
    when(() => mockAudioPlayer.setAudioSource(any()))
        .thenAnswer((_) async => Duration.zero);

    // Установка громкости
    when(() => mockAudioPlayer.setVolume(any()))
        .thenAnswer((_) async {});

    // Очистка
    when(() => mockAudioPlayer.dispose())
        .thenAnswer((_) async {});

    // Возвращалка значений
    when(() => mockAudioPlayer.playing).thenReturn(false);

    // Стримы
    when(() => mockAudioPlayer.playerStateStream)
        .thenAnswer((_) => Stream.value(
      PlayerState(true, ProcessingState.ready),
    ));

    when(() => mockAudioPlayer.playbackEventStream)
        .thenAnswer((_) => const Stream.empty());

    // Сервис
    service = PlayerService(mockAudioPlayer);

    // Список станций
    service.stations = [station1, station2];
  });

  group('Play', () {
    // Запуск плеера
    test('Start player', () async {
      await service.play(station1);

      verify(() => mockAudioPlayer.setAudioSource(any())).called(1);
      verify(() => mockAudioPlayer.play()).called(1);

      expect(service.state.currentStation, station1);
      expect(service.state.isPlaying, true);
      expect(service.state.error, null);
    });

    // Станция выбрана, но плеер не заработал
    test('The station is selected, but the player does not play', () async {
      service.setCurrentStationForTest(station1);
      when(() => mockAudioPlayer.playing).thenReturn(false);

      await service.play(station1);

      verify(() => mockAudioPlayer.play()).called(1);
      verifyNever(() => mockAudioPlayer.setAudioSource(any()));
      expect(service.state.currentStation, station1);
    });

    // Станция выбрана, но плеер уже работает
    test('Station already selected, player is playing', () async {
      service.setCurrentStationForTest(station1);
      when(() => mockAudioPlayer.playing).thenReturn(true);

      await service.play(station1);

      // Проверка на бездействие
      verifyNever(() => mockAudioPlayer.play());
      verifyNever(() => mockAudioPlayer.setAudioSource(any()));

      // Станция остаётся прежней
      expect(service.state.currentStation, station1);
    });

    // Если станция выбрана, но плеер не работает
    test('Station already selected, player is not playing', () async {
      // Устанавка текущей станции
      service.setCurrentStationForTest(station1);
      when(() => mockAudioPlayer.playing).thenReturn(false);
      await service.play(station1);

      // Проверка что play вызвался,
      verify(() => mockAudioPlayer.play()).called(1);
      // а setAudioSource нет
      verifyNever(() => mockAudioPlayer.setAudioSource(any()));
    });

    // Обработка ошибки старта плеера
    test('Play error sets state.error', () async {
      when(() => mockAudioPlayer.setAudioSource(any())).thenThrow(Exception());
      await service.play(station1);
      expect(service.state.error, AppError.playbackStart);
    });
  });

  group('Toggle play/pause', () {
    // Если плеер запущен
    test('The player is playing', () async {
      when(() => mockAudioPlayer.playing).thenReturn(true);
      await service.togglePlayPause();

      verify(() => mockAudioPlayer.pause()).called(1);
      verifyNever(() => mockAudioPlayer.play());
    });

    // Если плеер на паузе
    test('The player is paused', () async {
      when(() => mockAudioPlayer.playing).thenReturn(false);
      await service.togglePlayPause();

      verifyNever(() => mockAudioPlayer.pause());
      verify(() => mockAudioPlayer.play()).called(1);
    });

    // Обработка ошибки
    test('Playback control error', () async {
      when(() => mockAudioPlayer.playing).thenReturn(false);
      when(() => mockAudioPlayer.play()).thenThrow(Exception());
      await service.togglePlayPause();

      expect(service.state.error, AppError.playbackControl);
    });
  });

  group('Stop', () {
    test('Stop yomayo', () async {
      when(() => mockAudioPlayer.stop()).thenAnswer((_) async {});
      await service.stop();

      verify(() => mockAudioPlayer.stop()).called(1);
      expect(service.state, AudioPlayerState.empty);
    });
  });

  group('Set volume', () {
    test('Set volume yomayo', () async {
      when(() => mockAudioPlayer.setVolume(0.5)).thenAnswer((_) async {});
      await service.setVolume(0.5);

      verify(() => mockAudioPlayer.setVolume(0.5)).called(1);
      expect(service.state.volume, 0.5);
    });
  });

  group('Next station', () {
    // Бездействие в случае пустого списка станций
    test('Inaction if the station list is empty', () async {
      service.stations = [];
      await service.nextStation();
      expect(service.currentIndex, 0);
    });

    // Тест кругового переключения станций вперёд
    test('Switches to the next station in a circle', () async {
      service.stations = [station1, station2, station3];
      service.currentIndex = 0;

      await service.nextStation();
      expect(service.currentIndex, 1);

      await service.nextStation();
      expect(service.currentIndex, 2);

      await service.nextStation();
      expect(service.currentIndex, 0);
    });
  });

  group('Previous station', () {
    // Бездействие в случае пустого списка станций
    test('Inaction when the review list is empty', () async {
      service.stations = [];
      await service.previousStation();
      expect(service.currentIndex, 0);
    });

    // Тест кругового переключения станций назад
    test('Switches to the previous station in a circle', () async {
      service.stations = [station1, station2, station3];
      service.currentIndex = 0;

      await service.previousStation();
      expect(service.currentIndex, 2);

      await service.previousStation();
      expect(service.currentIndex, 1);

      await service.previousStation();
      expect(service.currentIndex, 0);
    });
  });

  test('Dispose', () {
    service.dispose();
    verify(() => mockAudioPlayer.dispose()).called(1);
  });
}