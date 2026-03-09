import 'package:flutter/material.dart';
import 'package:musicplayer/src/features/other/developer_room/developer_main/developer_main.dart';

import 'developer_main/quote_page.dart';

// Приветствие, пердупреждение и кнопка продолжить
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

                Text('Вы не сможете выйти отсюда не перезапустив приложение, раз уж нашли — идите до конца.\n',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Кнопка продолжить
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    QuotePage(
                      quote: '«В каждом человеке есть что-то, что он не покажет даже самому себе.»\nФёдор Достоевский',
                      nextPage: DeveloperMain(),
                    ),
                )
              );
            },

            child: Text('Продолжить'),
          ),
        ],
      ),
    );
  }
}