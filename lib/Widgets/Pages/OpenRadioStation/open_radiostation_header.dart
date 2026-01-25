import 'package:flutter/material.dart';
import 'package:musicplayer/data/radio_stations.dart';
import 'package:musicplayer/data/songs_test.dart';
import 'package:musicplayer/Widgets/Pages/OpenRadioStation/song_feed.dart';

final playlist = radioStations.first;

// Верхняя часть (не AppBar)
class OpenPlaylistHeader extends StatelessWidget {
  const OpenPlaylistHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final total = songsTest.map((s) => s.duration).reduce((a, b) => a + b); // Общая длительность плейлиста
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 50), // Отступ сверху по красоте
          // Иконка
          Icon(
            playlist.icon,
            size: 86,
          ),
          SizedBox(height: 15),
          // Название
          Text(
            playlist.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Описание
          Text(
            playlist.description,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          // Количество песен
          Text(
            "Кол-во песен: ${songsTest.length}",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          // Длительность плейлиста
          Text(
            "Длительность плейлиста: ${formatDuration(total)}",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),

          // Дополнительные кнопки
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Кнопка скачать
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.download, size: 30),
              ),
              // Кнопка воспроизвести
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_circle, size: 74),
              ),
              // Кнопка больше действий
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, size: 30),
              )
            ],
          ),
          Divider(indent: 16, endIndent: 16),
        ],
      ),
    );
  }
}

// Кастомный AppBar (просто захотелось вынести в отдельный файл)
class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
      : super(
    backgroundColor: Colors.transparent,
    // Параметры для прозрачности AppBar
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    actions: [
      // Поиск
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
    ],
  );
}