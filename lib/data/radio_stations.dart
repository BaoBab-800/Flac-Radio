import 'package:flutter/material.dart';

class RadioStations {
  final String title;       // Название
  final String description; // Описание
  final IconData icon;      // Значок/картинка
  final String streamUrl;

  const RadioStations({
    required this.title,
    required this.description,
    required this.icon,
    required this.streamUrl,
  });
}

const radioStations = [
  RadioStations(
    title: "Рок музыка",
    description: "Пока без описания",
    icon: Icons.album,
    streamUrl: "http://146.0.82.234:8000/live.flac",  // Потом сделать "http:/146.0.82.234:8000/rock_music/live.flac"
  ),
  RadioStations(
    title: "Метал",
    description: "Тоже без описания",
    icon: Icons.album,
    streamUrl: "http://146.0.82.234:8000/metal_music/live.flac",
  ),
  RadioStations(
    title: "Джаз",
    description: "Без описания",
    icon: Icons.album,
    streamUrl: "http://146.0.82.234:8000/jazz_music/live.flac",
  ),
];