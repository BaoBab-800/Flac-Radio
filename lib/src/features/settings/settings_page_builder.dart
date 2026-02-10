import 'package:flutter/material.dart';
import 'sections/appearance_section.dart';
import 'sections/language_section.dart';
import 'sections/player_section.dart';
import 'sections/reset_section.dart';

class SettingsPageBuilder extends StatelessWidget {
  const SettingsPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),

      body: ListView(
        children: [
          AppearanceSection(),
          LanguageSection(),
          PlayerSection(),
          ResetSection(),
        ],
      ),
    );
  }
}