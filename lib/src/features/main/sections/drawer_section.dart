import 'package:flutter/material.dart';
import 'package:musicplayer/src/app/app_routes.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

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
      padding: EdgeInsets.only(left: 24, top: 28, right: 12, bottom: 4), // внутренние отступы
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.l10n.menu, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)), // Заголовок

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
      children: [
        DrawerItem(icon: Icons.settings, titleKey: 'settings', route: AppRoute.settings),
        DrawerItem(icon: Icons.info_outline, titleKey: 'about', route: AppRoute.about),
      ],
    );
  }
}

// Отдельный пункт меню с иконкой и переходом по маршруту
class DrawerItem extends StatelessWidget {
  final IconData icon;    // иконка пункта
  final String titleKey;     // текст пункта
  final AppRoute route;   // маршрут для навигации

  const DrawerItem({
    required this.icon,
    required this.titleKey,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),   // иконка слева
      title: Text(context.l10n.byKey(titleKey)),    // название пункта
      onTap: () {
        Navigator.pop(context);                   // закрыть Drawer
        Navigator.pushNamed(context, route.path); // переход на страницу
      },
    );
  }
}