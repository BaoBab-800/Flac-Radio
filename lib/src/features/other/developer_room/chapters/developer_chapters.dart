import 'package:flutter/material.dart';

import 'package:musicplayer/src/app/app_routes.dart';

// Модель
class DeveloperChapters {
  final String title;
  final String description;
  final AppRoute route;
  final IconData icon;

  DeveloperChapters({
    required this.title,
    required this.description,
    required this.route,
    required this.icon,
  });
}

// Список
final chapters = [
  // Птицы
  DeveloperChapters(
    title: 'Птицы',
    description: 'Птицы - символ свободы запертый в клетке',
    route: AppRoute.chapterBird,
    icon: Icons.flag,
  ),
];