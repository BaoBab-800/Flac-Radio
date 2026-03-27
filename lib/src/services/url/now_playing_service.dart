import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/src/data/radio/models/player_metadata.dart';

class NowPlayingService {
  static const String _url = 'https://flacradio.duckdns.org/api/nowplaying';

  Future<PlayerMetadata?> fetchCurrentSong() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) return null;

    final decoded = jsonDecode(response.body);

    Map<String, dynamic>? data;

    if (decoded is List) {
      if (decoded.isEmpty) return null;
      data = decoded.first as Map<String, dynamic>;
    } else if (decoded is Map<String, dynamic>) {
      data = decoded;
    } else {
      throw Exception('Unexpected response format: ${decoded.runtimeType}');
    }

    return PlayerMetadata.fromJson(data);
  }
}