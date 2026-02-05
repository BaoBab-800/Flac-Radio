import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'radio_station_repository.dart';

/*
  Общая идея:
  Этот файл реализует локальный репозиторий радиостанций
  1. Данные хранятся в памяти
  2. Класс реализует интерфейс RadioStationRepository
  3. Используется как источник данных (data layer)
*/

class LocalRadioStationRepository implements RadioStationRepository {
  // локальное хранилище радиостанций в памяти
  final List<RadioStation> _stations = List.unmodifiable([
    RadioStation(
      id: "rock",
      title: "Rock radio",
      streamUrl: Uri.parse("https://146.0.82.234/public/flac_radio"),
    ),
  ]);

  // возвращает все радиостанции
  @override
  Future<List<RadioStation>> getAllStations() async {
    return List.unmodifiable(_stations);
  }

  // возвращает радиостанцию по id или null если не найдено
  // использование firstWhere с fallback вместо try/catch
  @override
  Future<RadioStation?> getById(String id) async {
    for (final station in _stations) {
      if (station.id == id) return station;
    }
    return null;
  }
}