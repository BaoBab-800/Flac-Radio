import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/services/player/player_service.dart';
import 'sections/header_section.dart';
import 'sections/drawer_section.dart';
import 'sections/feed/radio_station_feed.dart';
import 'sections/bottom_panel_section.dart';

class MainPageBuilder extends StatelessWidget {
  const MainPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Кастомный Drawer
      drawerEnableOpenDragGesture: false,
      drawer: MainPageDrawer(),

      // Содержимое страницы ёмаё
      body: Column(
        children: [
          const Header(), // "шапка" экрана
          Expanded(child: RadioStationFeed()),
        ],
      ),
      // Нижняя панель управления плеером
      bottomNavigationBar: context.watch<PlayerService>().state.currentStation == null
          ? null
          : const BottomPanelSection(),
    );
  }
}