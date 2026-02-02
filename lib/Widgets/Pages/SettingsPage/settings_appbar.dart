import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
      : super(
    backgroundColor: Colors.transparent,
    // Параметры для прозрачности AppBar
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    title: Text("Начинаем работу над функционалом", style: TextStyle(fontSize: 18))
  );
}