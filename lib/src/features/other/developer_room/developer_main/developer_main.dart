import 'package:flutter/material.dart';
import 'package:musicplayer/src/app/app_routes.dart';

import '../chapters/developer_chapters.dart';

class DeveloperMain extends StatelessWidget {
  const DeveloperMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      // Лента
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];

          return _ChapterTile(
            title: chapter.title,
            description: chapter.description,
            route: chapter.route,
            icon: chapter.icon,
          );
        },
      ),
    );
  }
}

// Конструктор пунктов ленты
class _ChapterTile extends StatelessWidget {
  final String title;
  final String description;
  final AppRoute route;
  final IconData icon;

  const _ChapterTile({
    required this.title,
    required this.description,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      subtitle: Text(description, style: TextStyle(color: Colors.grey[400])),

      onTap: () {
        Navigator.pushNamed(
          context,
          route.path,
        );
      },
    );
  }
}