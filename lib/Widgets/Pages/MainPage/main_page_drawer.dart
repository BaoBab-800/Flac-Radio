import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_page_builder.dart';
import 'package:musicplayer/Themes/theme_helper.dart';

// Drawer главного экрана
// Содержит заголовок и список навигационных пунктов
class MainPageDrawer extends StatelessWidget {
  final AppThemeOption currentTheme;
  final ValueChanged<AppThemeOption> onThemeChange;

  const MainPageDrawer({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),  // Верхняя часть Drawer
          const Divider(),
          _DrawerContent(
            currentTheme: currentTheme,
            onThemeChange: onThemeChange,
          ),
        ],
      ),
    );
  }
}

// Верхняя часть Drawer с заголовком и кнопкой закрытия
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 26,
        top: 32,
        right: 12,
        bottom: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Заголовок Drawer
          const Text(
            "Меню",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          // Кнопка закрытия Drawer
          IconButton(
            onPressed: () {
              // Закрытие Drawer без перехода между экранами
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, size: 28),
          ),
        ],
      ),
    );
  }
}

// Основное содержимое Drawer с пунктами меню
class _DrawerContent extends StatelessWidget {
  final AppThemeOption currentTheme;
  final ValueChanged<AppThemeOption> onThemeChange;

  const _DrawerContent({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Переход к экрану настроек
        DrawerItem(
          icon: Icons.settings,
          title: "Настройки",
          onTap: () {
            Navigator.pop(context); // закрываем Drawer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(
                  currentTheme: currentTheme,
                  onThemeChange: onThemeChange,
                ),
              ),
            );
          },
        ),
        // Временный пункт меню
        DrawerItem(
          icon: Icons.check,
          title: "Больше будет потом",
          onTap: () {},
        ),
      ],
    );
  }
}

// Отдельный пункт меню Drawer
// Выполняет закрытие Drawer и переход по маршруту
class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // теперь колбек

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Иконка пункта меню
      leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      // Название пункта меню
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      onTap: onTap,
    );
  }
}