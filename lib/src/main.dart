import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'core/di/providers.dart';
import 'app/app.dart';

/*
  Общая идея:
  Основная точка входа приложения
  1. Инициализация Flutter и необходимых сервисов
  2. Настройка JustAudioBackground для фонового воспроизведения
  3. Настройка глобальной обработки ошибок через Firebase Crashlytics
  4. Запуск приложения с MultiProvider для доступа к сервисам
*/

Future<void> main() async {
  // Инициализация Flutter
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  var backgroundAudioEnabled = false;

  // Настройка фонового воспроизведения (не для Web)
  if (!kIsWeb) {
    try {
      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.zavarkastudio.flacradio.channel.audio',
        androidNotificationChannelName: 'Flac Radio playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      );

      // Разрешение фонового аудио
      backgroundAudioEnabled = true;
    } catch (error, stackTrace) {
      backgroundAudioEnabled = false;

      // Логирование ошибок и стека
      debugPrint('JustAudioBackground.init failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  // Глобальная обработка ошибок Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    if (Firebase.apps.isNotEmpty) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      return;
    }
    FlutterError.presentError(details);
  };

  // Запуск приложения с обработкой ошибок через runZonedGuarded
  runZonedGuarded(() => runApp(
      MultiProvider(
        providers: buildAppProviders(
          backgroundAudioEnabled: backgroundAudioEnabled,
        ),
        child: const FlacRadioApp(),
      ),
    ), (error, stack) {
      if (Firebase.apps.isNotEmpty) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return;
      }

      // Локальное логирование ошибок, если Firebase не доступен
      debugPrint('Uncaught zone error: $error');
      debugPrintStack(stackTrace: stack);
    },
  );
}
