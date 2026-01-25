import 'package:flutter/material.dart';
import 'package:musicplayer/data/radio_stations.dart';
import 'package:musicplayer/Player/player_logic.dart';

enum _RadioStationActions { secure, }

// Лента с плейлистами
class PlaylistFeed extends StatelessWidget {
  const PlaylistFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,  // Удалить отступ сверху
      child: ListView.builder(
        itemCount: radioStations.length,
        itemBuilder: (context, index) {
          final playlist = radioStations[index];

          // Карточка с названием, описанием и иконкой радиостанции
          return ListTile(
            // Отступы
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            // При нажатии воспроизвести необходимую радиостанцию
            onTap: () {
              playFromServer(playlist.streamUrl);
            },
            // Иконка
            leading: Icon(playlist.icon),
            // Название
            title: Text(playlist.title),
            // Описание
            subtitle: Text(
              playlist.description,
              overflow: TextOverflow.ellipsis,
            ),
            // Кнопка три точки
            trailing: PopupMenuButton(
              onSelected: (action) {
                switch (action) {
                  case _RadioStationActions.secure:
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _RadioStationActions.secure,
                  child: Row(
                    children: [
                      Icon(Icons.push_pin, size: 20),
                      SizedBox(width: 10),
                      Text("Закрепить"),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}