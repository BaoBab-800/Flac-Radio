import 'package:flutter/material.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

enum _RadioStationActions { secure }

/*
  Общая идея:
  RadioStationTile расширенный виджет для отображения радиостанции в списке
  1. Показывает название и аватар станции
  2. Отображает контекстное меню с действиями, если передан ViewModel
  3. Делегирует воспроизведение станции через onTap
*/

class RadioStationTile extends StatelessWidget {
  final RadioStation station;                 // Модель радиостанции
  final VoidCallback onTap;                   // Callback при нажатии на элемент

  const RadioStationTile({
    super.key,
    required this.station,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),

      // Название радиостанции
      title: Text(
        station.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Аватар радиостанции:
      // Если задан imageUrl отображается изображение из сети
      // Если нет показывается иконка по умолчанию
      leading: station.imageUrl != null
          ? CircleAvatar(
        backgroundImage: NetworkImage(station.imageUrl.toString()),
      ) : const CircleAvatar(
        child: Icon(Icons.album),
      ),

      // Контекстное меню с дополнительными действиями
      trailing: PopupMenuButton<_RadioStationActions>(
        icon: Icon(Icons.more_vert),
        onSelected: (action) {
          debugPrint('Выбрано действие: $action для ${station.title}');
        },
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
      ),

      // Воспроизведение радиостанции по нажатию
      onTap: onTap,
    );
  }
}