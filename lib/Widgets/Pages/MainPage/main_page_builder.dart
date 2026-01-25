import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/bottom_panel_of_the_player.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_header.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/playlist_feed.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_drawer.dart';

// Главный экран
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Кастомный Drawer
      drawerEnableOpenDragGesture: false,
      drawer: MainPageDrawer(),

      // Содержимое страницы ёмаё
      body: Column(
        children: [
          const Header(), // "шапка" экрана
          Expanded(child: PlaylistFeed()),  // Лента с плейлистами
        ],
      ),
      // Нижняя панель управления плеером
      bottomNavigationBar: BottomPanelOfThePlayer(),
    );
  }
}