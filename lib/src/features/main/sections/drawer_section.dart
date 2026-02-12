import 'package:flutter/material.dart';
import 'package:musicplayer/src/app/app_routes.dart';

/*
  Общая идея:
  MainPageDrawer отображает боковое меню приложения
  Содержит заголовок и список пунктов, которые ведут к разным страницам
*/

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          _DrawerHeader(),   // Заголовок с кнопкой закрытия
          Divider(),         // Разделитель
          _DrawerContent(),  // Список пунктов меню
        ],
      ),
    );
  }
}

// Заголовок бокового меню с кнопкой закрытия
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 26, top: 32, right: 12, bottom: 6), // внутренние отступы
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Меню", style: TextStyle(fontSize: 24)), // Заголовок

          // Кнопка закрытия меню
          IconButton(
            onPressed: () => Navigator.pop(context),  // закрывает Drawer
            icon: Icon(Icons.close, size: 28),
          ),
        ],
      ),
    );
  }
}

// Содержимое меню с пунктами
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DrawerItem(icon: Icons.settings, title: 'Настройки', route: AppRoute.settings),
        DrawerItem(icon: Icons.info_outline, title: 'О приложении', route: AppRoute.about),
      ],
    );
  }
}

// Отдельный пункт меню с иконкой и переходом по маршруту
class DrawerItem extends StatelessWidget {
  final IconData icon;    // иконка пункта
  final String title;     // текст пункта
  final AppRoute route;   // маршрут для навигации

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),   // иконка слева
      title: Text(title),    // название пункта
      onTap: () {
        Navigator.pop(context);                   // закрыть Drawer
        Navigator.pushNamed(context, route.path); // переход на страницу
      },
    );
  }
}