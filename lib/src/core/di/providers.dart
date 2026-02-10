import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/src/services/theme/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/core/settings/shared_prefs_settings_repository.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  appProviders собирает все провайдеры для приложения
  1. Создаёт и управляет жизненным циклом объектов AudioPlayer и сервисов
  2. Делает сервисы доступными через контекст Provider
  3. Обеспечивает инициализацию SettingsService с загрузкой настроек
*/

final List<SingleChildWidget> appProviders = [
  // Провайдер аудиоплеера с автоматическим освобождением ресурсов
  Provider<AudioPlayer>(
    create: (_) => AudioPlayer(),
    dispose: (_, player) => player.dispose(),
  ),

  // Провайдер сервиса плеера, получает AudioPlayer через контекст
  Provider<PlayerService>(
    create: (context) => PlayerService(
      context.read<AudioPlayer>(),
    ),
  ),

  // Провайдер репозитория настроек через SharedPreferences
  Provider<SettingsRepository>(
    create: (_) => const SharedPrefsSettingsRepository(),
  ),

  // Провайдер SettingsService с инициализацией и уведомлением слушателей
  ChangeNotifierProvider<SettingsService>(
    create: (context) => SettingsService(
      context.read<SettingsRepository>(),
    )..init(),
  ),

  // Провайдер контроллера темы, синхронизированного с глобальными настройками
  ChangeNotifierProvider<ThemeController>(
    create: (context) => ThemeController(
      context.read<SettingsService>(),
    ),
  ),
];