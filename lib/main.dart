import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_builder.dart';
import 'package:musicplayer/Themes/theme_helper.dart';
import 'package:musicplayer/app_routes.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppThemeOption _currentTheme = AppThemeOption.system;

  void _changeTheme(AppThemeOption newTheme) {
    setState(() {
      _currentTheme = newTheme; // меняем тему
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Убрать баннер отладки
      title: "Flac Radio",
      // Темы
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      themeMode: mapThemeMode(_currentTheme),

      // routes: AppRoutes.routes,           // Маршруты навигации
      home: MainPage(
        currentTheme: _currentTheme,
        onThemeChange: _changeTheme,
      ),
    );
  }
}