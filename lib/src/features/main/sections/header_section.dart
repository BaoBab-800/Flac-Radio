import 'package:flutter/material.dart';

// Список действий для трёх точек
enum _MenuAction { sort, }

// Класс-сборщик "Шапки"
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          SizedBox(height: 20),

          // Горизонтальная линия приколов (я не знаю как это назвать)
          Row(
            children: [
              _LeftSection(), // "Flac Radio"
              Spacer(), // Разделитель на оставшееся простансво
              _RightSection(),  // Три точки "больше"
            ],
          ),
          Divider(),  // Для красоты
        ],
      ),
    );
  }
}

// "Flac Radio"
class _LeftSection extends StatelessWidget {
  const _LeftSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Иконка меню
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        ),

        // "Flac Radio"
        const Text(
          "Flac Radio",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Три точки "больше"
class _RightSection extends StatelessWidget {
  const _RightSection();

  @override
  Widget build(BuildContext context) {
    // Пока только кнока "Сортировка"
    return PopupMenuButton<_MenuAction>(
      onSelected: (action) {
        switch (action) {
          case _MenuAction.sort:
          // TODO: сделать меню сортировки
            break;
        }
      },
      itemBuilder: (context) => [
        // Сортировка
        PopupMenuItem(
          value: _MenuAction.sort,
          child: Text("Сортировка"),
        ),
      ],
    );
  }
}