import 'package:flutter/material.dart';

/*
  Тут будут настройки плеера:
  1. Автовоспроизведение при выборе станции (потом)
  2. Продолжать играть в фоне
  3. Начальная громкость
  4. Поведение при потере сети
*/

class SettingsPlayback extends StatelessWidget {
  const SettingsPlayback({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Продолжать играть в фоне"),
          trailing: Switch(
            value: true,
            onChanged: (val) {},
          ),
        ),
        ListTile(
          title: Text("Начальная громкось"),
          // Завтра сделать выбор по процентам
        ),
        // И доделать остальные пункты
      ],
    );
  }
}