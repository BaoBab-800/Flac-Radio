import 'dart:convert';
import 'dart:typed_data';

class Song {
  final String title;
  final String artist;
  final Uint8List? iconBytes; // Картинка в виде байтов

  Song({
    required this.title,
    required this.artist,
    this.iconBytes,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    Uint8List? bytes;
    if (json['icon'] != null) {
      try {
        bytes = base64Decode(json['icon']); // Преобразование base64 в Uint8List
      } catch (e) {
        bytes = null;
      }
    }

    return Song(
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      iconBytes: bytes,
    );
  }
}