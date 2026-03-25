import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/l10n/context_l10n_extension.dart';
import 'package:musicplayer/src/services/url/url_launcher_service.dart';

/*
  Общая идея:
  Страница "О приложении"
  1. Показывает приветствие, контент, ссылки на проект
  2. Магический счётчик скрытой функции, открывающей "Developer Room"
  3. Использует AudioPlayer для потенциального звукового эффекта
*/

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  int _strangeCounter = 0;           // Магический счётчик нажатий
  bool _fromLongPress = false;       // Проверка источника запуска
  bool _argsLoaded = false;          // Флаг однократной загрузки аргументов

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_argsLoaded) {
      _fromLongPress = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
      _argsLoaded = true;
    }
  }

  // Диалог предупреждения о настройках
  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: Text(
            context.l10n.settingsResetWarning,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                _strangeCounter++;

                // Магический триггер: 10 нажатий + длинное нажатие открывает Developer Room
                if (_strangeCounter >= 10 && _fromLongPress) {
                  _strangeCounter = 0;
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/developerRoomStart',
                        (route) => false,
                  );
                }
              },
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.about,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Divider(height: 2),
            const SizedBox(height: 14),

            _buildGreetingButton(),
            const SizedBox(height: 6),

            _buildContentText(),
            const SizedBox(height: 4),

            _buildEnjoyText(),
            const SizedBox(height: 10),

            _buildLinksSection(),
          ],
        ),
      ),
    );
  }

  // Приветствие
  Widget _buildGreetingButton() {
    return TextButton(
      onPressed: _showWarningDialog,
      child: Text(
        context.l10n.aboutGreetings,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Основной контент
  Widget _buildContentText() {
    return Text(
      context.l10n.aboutPageContent,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // "Наслаждайтесь"
  Widget _buildEnjoyText() {
    return Text(
      context.l10n.aboutEnjoy,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Ссылки
  Widget _buildLinksSection() {
    return Column(
      children: [
        Text(
          context.l10n.aboutLinks,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 4),

        LinkText(
          text: context.l10n.aboutGithub,
          url: 'https://github.com/BaoBab-800/Flac-Radio',
        ),
        const SizedBox(height: 2),

        LinkText(
          text: context.l10n.aboutSupport,
          url: 'https://заглушка',
        ),
      ],
    );
  }
}

// Виджет ссылки
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
      onTap: () => context.read<UrlLauncherService>().open(url),
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