import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:musicplayer/src/core/theme/app_colors.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

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
        context.l10n.byKey(station.titleKey),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Аватар радиостанции:
      // Если задан imageUrl отображается изображение из сети
      // Если нет показывается иконка по умолчанию
      leading: station.imagePath != null
          ? CircleAvatar(
        backgroundImage: AssetImage(station.imagePath!),
      ) : const CircleAvatar(
        child: Icon(Icons.album),
      ),

      // Три точки справа
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        color: context.colors.onBackground,

        // Пока только скопировать ссылку
        onSelected: (value) {
          if (value == 'copy') {
            // Копирование
            Clipboard.setData(
              ClipboardData(text: station.streamUrl.toString()),
            );

            // Сообщение о успешном копировании
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ссылка скопирована'),
                behavior: SnackBarBehavior.floating,

                margin: EdgeInsets.only(
                  bottom: 12,
                  left: 16,
                  right: 16,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },

        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'copy',
            child: Text(context.l10n.copyLink),
          ),
        ],
      ),

      // Воспроизведение радиостанции по нажатию
      onTap: onTap,
    );
  }
}