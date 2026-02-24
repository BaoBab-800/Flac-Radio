import 'package:url_launcher/url_launcher.dart';

// Открывалка Url
class UrlLauncherService {
  Future<void> open(String url) async {
    final uri = Uri.parse(url);

    // Результат открывания сслыи записан в переменную
    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    // При неудаче ошибка выводится наверх стека
    if (!success) {
      throw Exception('Could not launch $url');
    }
  }
}