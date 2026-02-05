import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/providers.dart';
import 'app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MusicPlayerApp(),
    ),
  );
}