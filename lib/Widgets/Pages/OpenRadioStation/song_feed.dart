import 'package:flutter/material.dart';
import 'package:musicplayer/data/songs_test.dart';

// Функция форматирования длительности песни
String formatDuration(Duration d) {
  final minutes = d.inMinutes;
  final seconds = d.inSeconds % 60;

  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

// Лента с песнями
class SongFeed extends StatelessWidget {
  const SongFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final song = songsTest[index];

          // Конструктор карточек песен
          return ListTile(
            // Потом нужно будет сделать нормальные картинки
            leading: Icon(song.icon),
            // Название
            title: Text(song.title),
            // Автор и длительность песни
            subtitle: Row(
              children: [
                Text(song.author),
                Text(" - ${formatDuration(song.duration)}"),
              ],
            ),
          );
        },
        childCount: songsTest.length, // Ограничитель
      ),
    );
  }
}