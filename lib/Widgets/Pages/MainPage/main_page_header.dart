import 'package:flutter/material.dart';

enum _MenuAction { sort, update }

// Класс-сборщик "Шапки"
class Header extends StatelessWidget {
  final VoidCallback onUpdate;

  const Header({
    super.key,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Горизонтальная линия приколов (я не знаю как это назвать)
          Row(
            children: [
              _LeftSection(), // "Flac Radio"
              Spacer(), // Разделитель на оставшееся простансво
              _RightSection(onUpdate: onUpdate),  // Три точки "больше"
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
        Text(
          "Flac Radio",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Три точки "больше"
class _RightSection extends StatelessWidget {
  final VoidCallback onUpdate;

  const _RightSection({required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    // Пока только кнока "Сортировка"
    return PopupMenuButton<_MenuAction>(
      icon: const Icon(Icons.more_vert),
      onSelected: (action) {
        switch (action) {
          case _MenuAction.sort:
          // TODO: сделать меню сортировки
            break;
          case _MenuAction.update:
            onUpdate();
            break;
        }
      },
      itemBuilder: (context) => [
        // Сортировка
        PopupMenuItem(
          value: _MenuAction.sort,
          child: Text("Сортировка"),
        ),
        // Обновить список
        PopupMenuItem(
          value: _MenuAction.update,
          child: Text("Обновить список"),
        )
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