import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/services/player/player_service.dart';

// список глобальных провайдеров для приложения
// используется для внедрения зависимостей через Provider
List<Provider> appProviders = [
  // провайдер аудиоплеера
  Provider<AudioPlayer>(
    create: (_) => AudioPlayer(), // создаёт один экземпляр AudioPlayer на всё приложение
    dispose: (_, player) => player.dispose(), // dispose автоматически освобождает ресурсы при уничтожении провайдера
  ),

  // провайдер сервиса управления плеером
  // получает AudioPlayer из контекста и передаёт в PlayerService
  // обеспечивает доступ к сервису из любого места приложения через Provider
  Provider<PlayerService>(
    create: (context) => PlayerService(
      context.read<AudioPlayer>(),
    ),
  ),
];