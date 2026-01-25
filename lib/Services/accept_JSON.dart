import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/data/song_model.dart';
import 'package:flutter/services.dart' show rootBundle;

// Функция запроса json
Future<Song> fetchCurrentSong() async {
  // TODO: Когда Виталя сделает отправку json - заменить ссылку
  final response = await http.get(Uri.parse('http://yourserver.com/current_song'));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return Song.fromJson(jsonData);
  } else {
    throw Exception('Failed to load song');
  }
}

// Для теста
Future<Song> fetchCurrentSongFromFile() async {
  final jsonString = await rootBundle.loadString('assets/now_playing.json');
  final jsonData = json.decode(jsonString);
  return Song.fromJson(jsonData);
}