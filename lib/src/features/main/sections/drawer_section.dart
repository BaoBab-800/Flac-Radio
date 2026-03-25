import 'package:flutter/material.dart';
import 'package:musicplayer/src/app/app_routes.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

// Боковое меню главной страницы
class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: _DrawerContent(),
    );
  }
}

// Заголовок Drawer
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 28, right: 12, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Текст "Меню"
          Text(
            context.l10n.menu,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Кнопка закрывающая Drawer
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 28),
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
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        // Заголовок
        _DrawerHeader(),

        // Разделитель
        Divider(),

        // Настройки
        DrawerItem(
          icon: Icons.settings,
          titleKey: 'settings',
          route: AppRoute.settings,
        ),

        // О приложении
        DrawerItem(
          icon: Icons.info_outline,
          titleKey: 'about',
          route: AppRoute.about,
          supportsLongPress: true,
        ),
      ],
    );
  }
}

// Конструктор пунктов
class DrawerItem extends StatelessWidget {
  final IconData icon;  // Иконка
  final String titleKey;  // Название
  final AppRoute route; // Путь к странице
  final bool supportsLongPress; // Действие при зажатии

  const DrawerItem({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.route,
    this.supportsLongPress = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Иконка
      leading: Icon(icon),

      // Название
      title: Text(context.l10n.byKey(titleKey)),

      // При нажатии перейти по пути
      onTap: () async {
        Navigator.pop(context);
        await Navigator.pushNamed(
          context,
          route.path,
          arguments: false,
        );
      },

      // При удержании передаются аргументы и переход по пути
      onLongPress: supportsLongPress ? () async {
        Navigator.pop(context);
        await Navigator.pushNamed(
          context,
          route.path,
          arguments: true,
        );
      } : null,
    );
  }
}