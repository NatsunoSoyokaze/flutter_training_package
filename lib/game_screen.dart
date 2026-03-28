import 'package:flutter/material.dart';

import 'core/app_info.dart';

void main() {
  runApp(const HokkeApp());
}

class HokkeApp extends StatelessWidget {
  const HokkeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ホッケヨーイ！',
      home: const StartScreen(),
    );
  }
}

/// スタート画面
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
          /// 🎮 中央コンテンツ
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "ホッケヨーイ",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // ゲーム画面へ
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                  child: const Text("START"),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "© 2026 Soyokaze",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),

          /// 📦 右下バージョン表示
          Positioned(
            bottom: 16,
            right: 16,
            child: FutureBuilder<String>(
              future: AppInfo.getVersion(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return Text(
                  snapshot.data!,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ゲーム画面
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int taps = 0;
  int okawariCount = 0;
  int eaten = 0;
  final int maxTaps = 20;

  List<bool> visibleList = [];

  @override
  void initState() {
    super.initState();
  }

  void _eatHokke() {
    setState(() {
      if (visibleList.contains(true)) {}
      taps++;
      eaten++;

      if (taps >= 20) {
        okawariCount++;
        taps = 0;
      }
    });
  }

  void eatHokke() {
    if (taps >= maxTaps) return;

    setState(() {
      taps++;
    });
  }

  String getHokkeImage() {
    if (taps >= 20) return 'assets/images/hokke_100.png';
    if (taps >= 15) return 'assets/images/hokke_75.png';
    if (taps >= 10) return 'assets/images/hokke_50.png';
    if (taps >= 5) return 'assets/images/hokke_25.png';
    return 'assets/images/hokke_0.png';
  }

  @override
  Widget build(BuildContext context) {
    final isBone = taps >= maxTaps;

    return Scaffold(
      appBar: AppBar(title: const Text('ホッケヨーイ！ゲーム')),
      body: GestureDetector(
        onTap: _eatHokke,
        child: Container(
          color: Colors.lightBlue[50],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ホッケをタップして食べよう！', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: eatHokke,
                child: Image.asset(
                  getHokkeImage(),
                  width: 250,
                ),
              ),

              const SizedBox(height: 30),
              Text('タップ数: $taps / 20', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                'おかわり: $okawariCount匹',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
