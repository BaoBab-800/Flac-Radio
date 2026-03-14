import 'package:flutter/material.dart';

class DeveloperRoomStart extends StatelessWidget {
  const DeveloperRoomStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 32),

          // Содержимое
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                Text('Добро пожаловать!\n',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Text(
                  'Если вы попали сюда случайно, то я вас поздравляю, вы нашли секретное место разработчика.\n'
                  'Но если вы попали сюда посмотрев ихсодный код, то вы сыграли очень грязно и недостойны находится здесь.\n',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),

                Text('На данный момент это место ещё не готово. Ожидайте.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}