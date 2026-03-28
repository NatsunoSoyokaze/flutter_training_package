import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final String videoPath;

  const VideoPreviewScreen({super.key, required this.videoPath});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.file(
      File(widget.videoPath),
    )..initialize().then((_) {
      setState(() {});
      controller.play();
    });
  }

  Future<void> saveVideo() async {
    await GallerySaver.saveVideo(widget.videoPath);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Video Preview")),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Retake"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                },
                child: const Text("Play / Pause"),
              ),
              ElevatedButton(
                onPressed: () {
                  saveVideo();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("保存しました")),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      )
    );
  }
}