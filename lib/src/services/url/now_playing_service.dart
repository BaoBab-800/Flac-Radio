import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/src/data/radio/models/player_metadata.dart';

class NowPlayingService {
  static const String _url = 'https://flacradio.duckdns.org/api/nowplaying';

  Future<PlayerMetadata?> fetchCurrentSong() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PlayerMetadata.fromJson(jsonData);
    } else {
      return null;
    }
  }
}