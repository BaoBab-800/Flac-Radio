import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/providers.dart';
import 'app/app.dart';

/*
  Общая идея:
  Точка входа в приложение
  1. Инициализирует все глобальные провайдеры через MultiProvider
  2. Подключает FlacRadioApp как корневой виджет приложения
  3. Обеспечивает доступ к сервисам и состояниям через Provider
*/

void main() {
  runApp(
    MultiProvider(
      providers: appProviders, // Список глобальных провайдеров приложения
      child: const FlacRadioApp(), // Корневой виджет приложения
    ),
  );
}