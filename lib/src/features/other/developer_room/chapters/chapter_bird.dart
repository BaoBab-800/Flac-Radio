import 'package:flutter/material.dart';

// Глава посвященная свободе и птицам
class ChapterBird extends StatelessWidget {
  const ChapterBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Символ свободы запертый в клетке',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      body: Center(
        child: Text(
          'Здесь будут мои мысли про птиц и свободу',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}