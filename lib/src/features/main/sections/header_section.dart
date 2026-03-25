import 'package:flutter/material.dart';

/*
  Общая идея:
  Header отображает верхнюю часть экрана
  1. Содержит кнопку открытия Drawer
  2. Отображает название приложения
*/

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: Column(
        children: [
          const SizedBox(height: 20),

          const _LeftSection(),

          const Divider(),
        ],
      ),
    );
  }
}

class _LeftSection extends StatelessWidget {
  const _LeftSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Открытие Drawer
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),

        const Text(
          'Flac Radio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}