import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';
import 'package:musicplayer/src/services/url/url_launcher_service.dart';

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
            Divider(height: 2),
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
            SizedBox(height: 4),
            // "Наслаждайтесь музыкой!"
            Text(
              context.l10n.aboutEnjoy,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Ссылки
            Text(
              context.l10n.aboutLinks,
              style: TextStyle(fontSize: 18),
            ),
            // GitHub
            LinkText(
              text: context.l10n.abourGithub,
              url: 'https://github.com/BaoBab-800/Flac-Radio',
            ),
            // Patreon
            LinkText(
              text: context.l10n.aboutSupport,
              url: 'https://заглушка',
            )
          ],
        ),
      ),
    );
  }
}

// Класс помошник для ссылок в тексте
class LinkText extends StatelessWidget {
  final String text;
  final String url;

  const LinkText({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<UrlLauncherService>().open(url);
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: 18,
        ),
      ),
    );
  }
}