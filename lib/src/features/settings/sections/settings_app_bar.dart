import 'package:flutter/material.dart';

/*
  Общая идея:
  Кастомный AppBar для экранов настроек
  1. Инкапсулирует логику отображения кнопки "Назад"
  2. Позволяет гибко управлять заголовком и actions
  3. Реализует PreferredSizeWidget для корректной работы в Scaffold
*/

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {

  const SettingsAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.centerTitle = true,
  });

  final String title;               // Заголовок AppBar
  final List<Widget>? actions;      // Дополнительные действия справа
  final bool showBackButton;        // Флаг отображения кнопки "Назад"
  final bool centerTitle;           // Центрирование заголовка

  @override
  Widget build(BuildContext context) {
    // Проверка есть ли возможность вернуться назад по навигационному стеку
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      // Кнопка "Назад" отображается только если:
      // 1. showBackButton == true
      // 2. В навигационном стеке есть предыдущий экран
      leading: (showBackButton && canPop)
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ) : null,

      // Заголовок AppBar
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      // Выравнивание заголовка
      centerTitle: centerTitle,

      // Действия справа
      actions: actions,
    );
  }

  // Обязательная реализация для PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}