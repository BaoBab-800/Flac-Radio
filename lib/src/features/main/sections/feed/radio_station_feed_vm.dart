import 'package:flutter/foundation.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/data/radio/repository/radio_station_repository.dart';
import 'package:musicplayer/src/services/player/player_service.dart';

/*
  Общая идея:
  RadioStationFeedViewModel управляет состоянием списка радиостанций и их воспроизведением
  1. Загружает список радиостанций из репозитория
  2. Хранит состояние загрузки, ошибки и список станций
  3. Обеспечивает взаимодействие с PlayerService для воспроизведения выбранной станции
*/

class RadioStationFeedViewModel extends ChangeNotifier {
  final RadioStationRepository repository; // Источник данных радиостанций
  final PlayerService playerService;             // Сервис управления плеером

  List<RadioStation>? stations; // Список загруженных радиостанций
  Object? error;                // Ошибка при загрузке списка
  bool isLoading = true;        // Индикатор процесса загрузки

  RadioStationFeedViewModel({
    required this.repository,
    required this.playerService,
  }) {
    // Автоматическая загрузка станций при создании VM
    loadStations();
  }

  // Загрузка списка радиостанций из репозитория
  Future<void> loadStations() async {
    isLoading = true;
    notifyListeners(); // Уведомление UI о начале загрузки

    try {
      stations = await repository.getAllBaseStations();
      playerService.stations = stations!;
      error = null; // Сброс ошибок при успешной загрузке
    } catch (e) {
      stations = null; // Очистка списка при ошибке
      playerService.stations = const [];
      error = e;       // Сохранение ошибки
    } finally {
      isLoading = false;
      notifyListeners(); // Уведомление UI о завершении загрузки
    }
  }

  // Запуск воспроизведения выбранной радиостанции
  Future<void> playStation(
      RadioStation station, {
        required String localizedTitle,
        required Map<String, String> localizedTitlesByKey,
      }) async {
    await playerService.play(
      station,
      localizedTitle: localizedTitle,
      localizedTitlesByKey: localizedTitlesByKey,
    );
  }

  String? get selectedStationId => playerService.state.currentStation?.id;

  // Удобное свойство для проверки, что список пуст и загрузка завершена
  bool get isEmpty => !isLoading && (stations == null || stations!.isEmpty);
}