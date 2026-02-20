import 'package:collection/collection.dart';
import 'radio_station_model.dart';

class RadioStationsRepository {
  // Локальный список радиостанций, защищённый от изменений
  final List<RadioStationModel> _stations = List.unmodifiable([
    // Rock
    RadioStationModel(
      id: 'rock',
      titleKey: 'rockRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imageUrl: Uri.parse('https://e7.pngegg.com/pngimages/72/807/png-clipart-guitar-hero-rock-logo-bass-guitar-guitar-text-logo-thumbnail.png'),
    ),
    // Metal
    RadioStationModel(
      id: 'metal',
      titleKey: 'metalRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
    // Jazz
    RadioStationModel(
      id: 'jazz',
      titleKey: 'jazzRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
    // Pop
    RadioStationModel(
      id: 'pop',
      titleKey: 'popRadio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
  ]);

  // Получение всех радиостанций
  List<RadioStationModel> getAll() => _stations;

  // Получение радиостанции по идентификатору
  RadioStationModel? getById(String id) => _stations.firstWhereOrNull((s) => s.id == id);
}