import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/core/theme/app_colors.dart';
import 'package:musicplayer/src/services/player/player_contracts.dart';
import 'sections/header_section.dart';
import 'sections/drawer_section.dart';
import 'sections/feed/radio_station_feed.dart';
import 'sections/bottom_panel_section.dart';

// Сборщик основной страницы
class MainPageBuilder extends StatelessWidget {
  const MainPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final hasCurrentStation = context.watch<PlayerStateReader>().state.currentStation != null;

    return Scaffold(
      backgroundColor: context.colors.background,

      // Кастомный Drawer
      drawer: MainPageDrawer(),

      // Содержимое страницы ёмаё
      body: Column(
        children: [
          const Header(), // "шапка" экрана
          Expanded(child: RadioStationFeed()),
        ],
      ),

      // Нижняя панель управления плеером
      bottomNavigationBar: hasCurrentStation ? const BottomPanelSection() : null,
    );
  }
}
