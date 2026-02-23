import 'package:flutter/material.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

class About extends StatelessWidget {
  const About({super.key});

  // Магический диалог
  void warningDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext) {
        return AlertDialog(
          content: Text(
            context.l10n.settingsResetWarning,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok', style: TextStyle(fontSize: 16)),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar только с текстом
      appBar: AppBar(
        title: Text(
          context.l10n.about,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // Содержимое страницы
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(),
            SizedBox(height: 14),

            // Магическое приветствие
            TextButton(
              onPressed: () {
                warningDialog(context);
              },

              child: Text(
                context.l10n.aboutGreetings,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 6),
            // Содержание
            Text(
              context.l10n.aboutPageContent,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            // Поддержите разработчика
            Text(
              context.l10n.aboutSupport,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}