import 'package:flutter/material.dart';

// Класс-сборщик Drawer
class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          Divider(),
          const _DrawerContent(),
        ],
      ),
    );
  }
}

// Верхняя часть Drawer
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 26, top: 32, right: 12, bottom: 6), // Потом наверное поменяю
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Меню"
          const Text(
            "Меню",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          // Кнопка крестик
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Закрываем Drawer
            },
            icon: Icon(Icons.close, size: 28),
          ),
        ],
      ),
    );
  }
}

// Содержимое Drawer
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DrawerItem(icon: Icons.settings, title: "Настройки", route: "/settings"),
        DrawerItem(icon: Icons.check, title: "Больше будет потом", route: "/more"),
      ],
    );
  }
}

// Пункт меню
class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}