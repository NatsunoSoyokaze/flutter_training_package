import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc/camera_screen.dart';
import 'package:nfc/gallery_page.dart';
import 'package:nfc/game_screen.dart';
import 'package:nfc/license_screen.dart';
import 'package:video_player/video_player.dart';

import 'package/service/photo_service.dart';

void main() {
  // main 関数内で非同期処理を呼び出すための設定
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HokkeApp());
}

class HokkeApp extends StatelessWidget {
  const HokkeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: const LicenseScreen()),
    );
  }
}

class HokkePage extends StatefulWidget {
  const HokkePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// main関数、MyApp、MyHomePageはデフォルトから変更がないため省略

class _MyHomePageState extends State<HokkePage> {
  VideoPlayerController? _controller;
  final imagePicker = ImagePicker();

  // カメラから動画を取得するメソッド
  Future getVideoFromCamera() async {
    XFile? pickedFile = await imagePicker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      _controller = VideoPlayerController.file(File(pickedFile.path));
      _controller!.initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
    }
  }

  // ギャラリーから動画を取得するメソッド
  Future getVideoFromGallery() async {
    XFile? pickedFile = await imagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _controller = VideoPlayerController.file(File(pickedFile.path));
      _controller!.initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test")),
      body: Center(
        // 取得した動画を表示(ない場合はメッセージ)
        child: _controller == null
            ? Text(
                '動画を選択してください',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            : VideoPlayer(_controller!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // カメラから取得するボタン
          FloatingActionButton(
            onPressed: getVideoFromCamera,
            child: const Icon(Icons.video_call),
          ),
          // ギャラリーから取得するボタン
          FloatingActionButton(
            onPressed: getVideoFromGallery,
            child: const Icon(Icons.movie_creation),
          ),
        ],
      ),
    );
  }
}
