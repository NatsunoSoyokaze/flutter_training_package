import 'package:flutter/material.dart';
import 'package:nfc/core/constants.dart';
import 'game_screen.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: Center(
        child: ElevatedButton(
          onPressed: () async => showLicensePage(
            context: context,
            applicationName: "Soyokaze Lab",
            applicationVersion: await Constants.getApplicationVersion(),
          ),

          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          ),
          child: const Text("ゲームスタート", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
