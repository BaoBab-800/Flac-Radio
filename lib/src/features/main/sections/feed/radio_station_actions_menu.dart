import 'package:flutter/material.dart';
import 'radio_station_feed_vm.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

enum _RadioStationActions { secure }

/*
  Общая идея:
  RadioStationActionsMenu отдельный виджет для отображения контекстного меню станции
  1. Позволяет вынести действия с радиостанцией в отдельный компонент
  2. Использует PopupMenuButton для отображения меню
  3. Делегирует выполнение действий через RadioStationFeedViewModel
*/

class RadioStationActionsMenu extends StatelessWidget {
  final RadioStation station;                // Модель радиостанции
  final RadioStationFeedViewModel viewModel; // ViewModel для выполнения действий

  const RadioStationActionsMenu({
    super.key,
    required this.station,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_RadioStationActions>(
      // Обработка выбора действия из меню
      onSelected: (action) {
        switch (action) {
          case _RadioStationActions.secure:
          // Закрепление выбранной станции через ViewModel
            viewModel.secureStation(station);
            break;
        }
      },
      // Элементы меню
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: _RadioStationActions.secure,
          child: Row(
            children: [
              Icon(Icons.push_pin, size: 20),
              SizedBox(width: 10),
              Text("Закрепить"),
            ],
          ),
        ),
      ],
    );
  }
}