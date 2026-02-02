import 'package:flutter/material.dart';

/*
  Тут будет инфорация:
  1. Версия приложения
  2. Используемые технологии
  3. Лицензии
  4. "Made with Flutter" (наверное)
*/

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("О приложении"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}