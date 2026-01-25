import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/OpenRadioStation/song_feed.dart';
import 'package:musicplayer/Widgets/Pages/OpenRadioStation/open_radiostation_header.dart';

// Пока-что всё в одном месте
class OpenPlaylistBuilder extends StatelessWidget {
  const OpenPlaylistBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Чтоб AppBar был действительно прозрачным
      // AppBar с стрелкой назад и поиском (пока поиск не работает)
      appBar: CustomAppBar(),

      // "Шапка" страницы и список песен
      body: CustomScrollView(
        slivers: [
          // "Шапка"
          OpenPlaylistHeader(),

          // Список
          SongFeed(),
        ],
      ),
    );
  }
}