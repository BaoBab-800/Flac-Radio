import 'package:flutter/material.dart';

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
          _LeftSection(), // "Flac Radio"
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