import 'dart:async';
import 'package:flutter/material.dart';

// Страница с цитатой
class QuotePage extends StatefulWidget {
  final String quote;
  final Widget nextPage;

  const QuotePage({
    super.key,
    required this.quote,
    required this.nextPage,
  });

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String _visibleText = ''; // Текст ввиде аргумента
  int _index = 0; // Индекс текущего символа
  bool _isVisible = true; // Для мигания

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  // Функция печати
  void _startTyping() {
    const typingSpeed = Duration(milliseconds: 50); // Скорость печати букв

    Timer.periodic(typingSpeed, (timer) {
      // Изменение состояния текста, который показывается на экране
      setState(() {
        _index++;
        _visibleText = widget.quote.substring(0, _index);
      });

      // Если текст закончился - после 2 секунд начнётся мигание
      if (_index == widget.quote.length) {
        timer.cancel();
        Future.delayed(const Duration(seconds: 2), _startBlinking);
      }
    });
  }

  // Функция мигания
  void _startBlinking() {
    const blinkDuration = Duration(milliseconds: 120); // Резкость мигания
    int blinkCount = 0; // Текущий блик
    const maxBlinks = 2;  // Сколько будет всего

    Timer.periodic(blinkDuration, (timer) {
      // Изменение видимости текста
      setState(() {
        _isVisible = !_isVisible;
      });

      if (!_isVisible) blinkCount++;

      // Если было максимальное количество бликов - переход на следующую страницу
      if (blinkCount >= maxBlinks) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget.nextPage),
        );
      }
    });
  }

  // Виджет текста
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Text(
            _isVisible ? _visibleText : '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}