import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_builder.dart';
import 'package:musicplayer/Themes/the_only_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music",
      theme: Themes.dark(),
      home: MainPage(),
    );
  }
}