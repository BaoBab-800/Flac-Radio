import 'package:flutter/material.dart';

// Мистическая страница
class MysteriousPage extends StatelessWidget {
  const MysteriousPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/sem.jpg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}