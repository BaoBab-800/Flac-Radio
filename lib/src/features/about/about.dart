import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/app/app_routes.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';
import 'package:musicplayer/src/services/url/url_launcher_service.dart';

// Страница "О приложении"
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  int _strangeCounter = 0;
  bool _fromLongPress = false;
  bool _argsLoaded = false;

  // Загрузка arguments
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Только один раз
    if (!_argsLoaded) {
      _fromLongPress = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
      _argsLoaded = true;
    }
  }

  // Магический диалог
  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          // Предупреждение
          content: Text(
            context.l10n.settingsResetWarning,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          // "Ок" c непонятной функцией...
          actions: [
            TextButton(
              // Проверка + скрытие диалога
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  _strangeCounter++;

                  // При 10 нажатиях + длинном нажатии пункта в Drawer переход на странную страницу...
                  if (_strangeCounter >= 10 && _fromLongPress) {
                    _strangeCounter = 0;
                    // При 10 нажатиях + длинном нажатии пункта в Drawer переход на странную страницу...

                    Navigator.pushNamed(
                      context,
                      AppRoute.developerRoom.path,
                    );
                  }
                });
              },

              // Сама кнопка
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

  // Сборщик контента страницы
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Просто AppBar
      appBar: AppBar(
        title: Text(
          context.l10n.about,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // Непосредственно контент
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Divider(height: 2),
            const SizedBox(height: 14),

            // Приветствие
            _buildGreetingButton(),
            const SizedBox(height: 6),

            // Контент
            _buildContentText(),
            const SizedBox(height: 4),

            // "Наслаждайтесь"
            _buildEnjoyText(),
            const SizedBox(height: 10),

            // Ссылки
            _buildLinksSection(),
          ],
        ),
      ),
    );
  }

  // Текст приветствия
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

  // Основной контент страницы
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
        LinkText(
          text: context.l10n.abourGithub,
          url: 'https://github.com/BaoBab-800/Flac-Radio',
        ),
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
      // Переход по ссылке
      onTap: () {
        context.read<UrlLauncherService>().open(url);
      },

      // Текст ссылки
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