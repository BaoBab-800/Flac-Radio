import 'package:flutter/material.dart';

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
          SizedBox(height: 16),

          // Горизонтальная линия приколов (я не знаю как это назвать)
          Row(
            children: [
              _LeftSection(), // "Flac Radio"
              Spacer(), // Разделитель на оставшееся простансво
              _RightSection(),  // Три точки "больше"
            ],
          ),

          // Горизонтальная линия кнопок сортировки
          // _SortingButtons(),
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
            color: Colors.white,
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

// Кнопки сортировки (может быть пригодиться)
/*
class _SortingButtons extends StatelessWidget {
  const _SortingButtons();

  @override
  Widget build(BuildContext context) {
    // Скролл-список
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _sortingCardDesigner("Рекомендуем"),
          _sortingCardDesigner("Рок"),
          _sortingCardDesigner("Металл"),
          _sortingCardDesigner("Поп"),
          _sortingCardDesigner("Подкасты"),
        ],
      ),
    );
  }

  // Конструктор карточек
  Widget _sortingCardDesigner(String name) {
    return TextButton(
      onPressed: () {},
      child: DecoratedBox(
        // Стиль фона
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        // Название карточки
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          // Название
          child: Text(
            name,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
*/