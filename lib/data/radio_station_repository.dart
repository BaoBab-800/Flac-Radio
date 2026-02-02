import 'package:musicplayer/data/radio_stations.dart';

abstract class RadioStationRepository {
  List<RadioStation> getStations();
}