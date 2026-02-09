import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/core/theme/theme_service.dart';
import 'package:musicplayer/src/core/theme/theme_data.dart';
import 'package:musicplayer/src/core/theme/app_theme_catalog.dart';
// import 'app_routes.dart';

class FlacRadioApp extends StatelessWidget {
  const FlacRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeType = context.watch<ThemeService>().themeType;
    final appTheme = AppThemes.byType(themeType);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flac Radio',

      theme: ThemeDataFactory.fromAppTheme(appTheme),
      // routes: appRoutes,
    );
  }
}