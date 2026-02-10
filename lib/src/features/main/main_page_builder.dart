import 'package:flutter/material.dart';
import 'sections/header_section.dart';
import 'sections/drawer_section.dart';

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
        ],
      ),
      // Нижняя панель управления плеером
      // bottomNavigationBar: BottomPanelOfThePlayer(),
    );
  }
}