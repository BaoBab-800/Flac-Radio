import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'radio_station_feed_vm.dart';
import 'radio_station_tile.dart';

import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  Презентационный виджет для отображения списка радиостанций
  1. Использует RadioStationFeedViewModel для управления состоянием списка и воспроизведения
  2. Отображает индикатор загрузки, ошибки или пустой список
  3. Формирует ListView с RadioStationTile для каждой радиостанции
  4. Делегирует воспроизведение через ViewModel, отделяя UI от логики
*/

class RadioStationFeed extends StatelessWidget {
  const RadioStationFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioStationFeedViewModel>(
      builder: (context, viewModel, child) {
        // Индикатор загрузки при ожидании данных
        if (viewModel.isLoading)
          return const Center(child: CircularProgressIndicator());

        // Отображение ошибки при загрузке
        if (viewModel.error != null)
          return Center(child: Text('${context.l10n.error}: ${viewModel.error}'));

        // Сообщение о пустом списке станций
        if (viewModel.isEmpty)
          return Center(child: Text(context.l10n.noStations));

        // Список радиостанций
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: viewModel.stations!.length,
          itemBuilder: (context, index) {
            final station = viewModel.stations![index];

            return RadioStationTile(
              station: station,
              isSelected: station.id == viewModel.selectedStationId,
              onTap: () {
                // Сначала локализация названия
                final localizedTitle = context.l10n.byKey(station.titleKey);
                final localizedTitlesByKey = {
                  for (final item in viewModel.stations!)
                    item.titleKey: context.l10n.byKey(item.titleKey),
                };

                // Передача локализованного названия в ViewModel
                viewModel.playStation(
                  station,
                  localizedTitle: localizedTitle,
                  localizedTitlesByKey: localizedTitlesByKey,
                );
              },
            );
          },
        );
      },
    );
  }
}