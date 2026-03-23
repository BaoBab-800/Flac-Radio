import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'core/di/providers.dart';
import 'app/app.dart';
import 'services/player/player_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    try {
      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.example.musicplayer.channel.audio',
        androidNotificationChannelName: 'Flac Radio playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      );
      PlayerService.backgroundAudioEnabled = true;
    } catch (error, stackTrace) {
      PlayerService.backgroundAudioEnabled = false;
      debugPrint('JustAudioBackground.init failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  } else {
    PlayerService.backgroundAudioEnabled = false;
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    if (Firebase.apps.isNotEmpty) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      return;
    }
    FlutterError.presentError(details);
  };

  runZonedGuarded(() => runApp(
      MultiProvider(
        providers: appProviders,
        child: const FlacRadioApp(),
      ),
    ), (error, stack) {
      if (Firebase.apps.isNotEmpty) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return;
      }
      debugPrint('Uncaught zone error: $error');
      debugPrintStack(stackTrace: stack);
    },
  );
}