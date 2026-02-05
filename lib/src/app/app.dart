import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/core/theme/theme_controller.dart';
import 'package:musicplayer/src//core/theme/app_theme.dart';
import 'app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.themeMode,

      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}