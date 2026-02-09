import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'radio_station_repository.dart';

/*
  Общая идея:
  LocalRadioStationRepository предоставляет локальный список радиостанций
  1. Хранит статический набор радиостанций в памяти
  2. Позволяет получать все станции или конкретную станцию по идентификатору
  3. Используется как источник данных до внедрения сетевого репозитория
  4. Гарантирует неизменяемость списка станций через List.unmodifiable
*/

class LocalRadioStationRepository implements RadioStationRepository {
  // Локальный список радиостанций, защищённый от изменений
  final List<RadioStation> _stations = List.unmodifiable([
    RadioStation(
      id: "rock",
      title: "Rock radio",
      streamUrl: Uri.parse("https://146.0.82.234/public/flac_radio"),
    ),
  ]);

  // Получение всех радиостанций
  @override
  Future<List<RadioStation>> getAllStations() async {
    return List.unmodifiable(_stations);
  }

  // Получение радиостанции по идентификатору
  @override
  Future<RadioStation?> getById(String id) async {
    for (final station in _stations) {
      if (station.id == id) return station; // Возврат найденной станции
    }
    return null; // Если станция не найдена вернуть null
  }
}