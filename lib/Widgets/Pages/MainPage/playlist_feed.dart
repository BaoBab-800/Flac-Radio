import 'package:flutter/material.dart';
import 'package:musicplayer/data/radio_stations.dart';

// Возможные действия для радиостанции в выпадающем меню
enum _RadioStationActions { secure }

// Лента со списком радиостанций
// Отображает все станции и выделяет текущую
class PlaylistFeed extends StatelessWidget {
  final List<RadioStation> stations;  // Список радиостанций для отображения
  final RadioStation? currentStation; // Текущая выбранная станция
  final void Function(RadioStation) onStationTap; // Callback на нажатие станции

  const PlaylistFeed({
    super.key,
    required this.stations,
    required this.currentStation,
    required this.onStationTap,
  });

  @override
  Widget build(BuildContext context) {
    // Убираем верхний padding, чтобы список начинался сразу после шапки
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];

          // Карточка одной станции
          // isSelected выделяет текущую станцию
          return _RadioStationTile(
            station: station,
            isSelected: station.id == currentStation?.id,
            onTap: () => onStationTap(station),
          );
        },
      ),
    );
  }
}

// Карточка отдельной радиостанции
// Показывает иконку, название, описание, цвет выделения и меню действий
class _RadioStationTile extends StatelessWidget {
  final RadioStation station;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioStationTile({
    super.key,
    required this.station,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      onTap: onTap, // Обработка нажатия на карточку
      leading: Icon(station.icon, size: 32),  // Иконка радиостанции слева
      title: Text(station.title), // Название станции
      // Описание станции
      subtitle: Text(
        station.description,
        overflow: TextOverflow.ellipsis,
      ),

      // Цвет выделения текущей станции
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,

      // Выпадающее меню для дополнительных действий
      trailing: PopupMenuButton<_RadioStationActions>(
        onSelected: (action) {
          switch (action) {
            case _RadioStationActions.secure:
            // TODO: закрепить станцию
              break;
          }
        },
        itemBuilder: (context) => const [
          // Закрепить
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
    );
  }
}