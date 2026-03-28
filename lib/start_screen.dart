import 'package:flutter/material.dart';
import 'game_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _goToGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: Center(
        child: ElevatedButton(
          onPressed: () => _goToGame(context),
          style: ElevatedButton.styleFrom(
            padding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          ),
          child: const Text(
            "ゲームスタート",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}