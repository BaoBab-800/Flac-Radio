import 'package:flutter/foundation.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/data/radio/repository/local_radio_station_repository.dart';
import 'package:musicplayer/src/services/player/player_service.dart';

/*
  Общая идея:
  RadioStationFeedViewModel управляет состоянием списка радиостанций и их воспроизведением
  1. Загружает список радиостанций из репозитория
  2. Хранит состояние загрузки, ошибки и список станций
  3. Обеспечивает взаимодействие с PlayerService для воспроизведения выбранной станции
  4. Предоставляет удобные свойства для UI: isEmpty, isLoading, error
*/

class RadioStationFeedViewModel extends ChangeNotifier {
  final LocalRadioStationRepository repository; // Источник данных радиостанций
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
      stations = await repository.getAllStations();
      error = null; // Сброс ошибок при успешной загрузке
    } catch (e) {
      stations = null; // Очистка списка при ошибке
      error = e;       // Сохранение ошибки
    } finally {
      isLoading = false;
      notifyListeners(); // Уведомление UI о завершении загрузки
    }
  }

  // Запуск воспроизведения выбранной радиостанции
  void playStation(RadioStation station) {
    playerService.play(station);
  }

  // Заглушка для закрепления станции
  // TODO: Потом сделать полноценно
  void secureStation(RadioStation station) {
    debugPrint('Станция закреплена: ${station.title}');
  }

  // Удобное свойство для проверки, что список пуст и загрузка завершена
  bool get isEmpty => !isLoading && (stations == null || stations!.isEmpty);
}