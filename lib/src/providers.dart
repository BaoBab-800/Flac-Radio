import 'package:provider/provider.dart';
import 'package:musicplayer/src/data/radio/radio_stations_repository.dart';
import 'package:musicplayer/src/services/theme/theme_service.dart';

// Список провайредов
final appProviders = [
  // Сервис тем
  ChangeNotifierProvider(create: (_) => ThemeService()),

  // Репозиторий радиостанций
  Provider(create: (_) => RadioStationsRepository()),
];