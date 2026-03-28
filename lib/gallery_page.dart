import 'dart:io';
import 'package:flutter/material.dart';
import 'package/service/photo_service.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final PhotoService _photoService = PhotoService();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ギャラリー取得')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : const Text('画像なし'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print("onPress?");
                final image =
                await _photoService.pickImage(context);
                print(image);
                if (image != null) {
                  setState(() {
                    _image = image;
                  });
                }
              },
              child: const Text('写真を選択'),
            ),
          ],
        ),
      ),
    );
  }
}