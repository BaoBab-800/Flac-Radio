import '../models/radio_station.dart';
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
  final List<RadioStation> _baseStations = List.unmodifiable([
    // Rock
    RadioStation(
      id: 'rock',
      titleKey: 'rockRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/rock_radio/radio.flac'),
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
    // Electronic
    RadioStation(
      id: 'electronic',
      titleKey: 'electronicRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imagePath: 'assets/images/electronic_icon.png'
    ),
  ]);

  final List<RadioStation> _localStations = [
    RadioStation(
      id: 'user',
      titleKey: 'userKey',
      streamUrl: Uri.parse('https://user/radio.flac'),
    )
  ];

  // Получение всех базовых радиостанций
  @override
  Future<List<RadioStation>> getAllBaseStations() async {
    return List.unmodifiable(_baseStations);
  }

  // Получение всех пользовательских радиостанций
  @override
  Future<List<RadioStation>> getAllLocalStations() async {
    return List.unmodifiable(_localStations);
  }

  // Получение базовой радиостанции по идентификатору
  @override
  Future<RadioStation?> getBaseStationById(String id) async {
    for (final station in _baseStations) {
      if (station.id == id) return station; // Возврат найденной станции
    }
    return null; // Если станция не найдена вернуть null
  }

  // Получение пользовательской радиостанции по идентификатору
  @override
  Future<RadioStation?> getLocalStationById(String id) async {
    for (final station in _localStations) {
      if (station.id == id) return station;
    }
    return null;
  }
}