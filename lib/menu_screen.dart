import 'package:flutter/material.dart';
import 'excuse_input_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('言い訳メーカー 超')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExcuseInputScreen()),
                );
              },
              child: const Text('言い訳を生成する'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('解析モード'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('使い方ガイド'),
            ),
          ],
        ),
      ),
    );
  }
}
