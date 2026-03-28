import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraPreviewScreen extends StatelessWidget {
  final String imagePath;

  const CameraPreviewScreen({super.key, required this.imagePath});

  Future<void> saveImage() async {
    await GallerySaver.saveImage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview")),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 撮り直し
                },
                child: const Text("Retake"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await saveImage();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("保存しました")),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}