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
    // Rock
    RadioStation(
      id: 'rock',
      titleKey: 'rockRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imagePath: 'assets/images/rock_icon.png',
    ),
    // Metal
    RadioStation(
      id: 'metal',
      titleKey: 'metalRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imagePath: 'assets/images/metal_icon.png',
    ),
    // Jazz
    RadioStation(
      id: 'jazz',
      titleKey: 'jazzRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imagePath: 'assets/images/jazz_icon.png'
    ),
    // Pop
    RadioStation(
      id: 'pop',
      titleKey: 'popRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
    // Electronic
    RadioStation(
      id: 'electronic',
      titleKey: 'electronicRadio',
      streamUrl: Uri.parse('https://music.youtube.com/watch?v=wz1ca1-_-MY&list=OLAK5uy_n1sOLxWCfeedpeiN-YS7H5xJq5Qptac-M'),
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