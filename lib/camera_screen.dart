import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nfc/camera_preview_screen.dart';
import 'package:nfc/videoo_preview_screen.dart';

enum CameraType { back, front }

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  bool isVideoMode = false;
  bool isRecording = false;
  bool isInitializing = false;

  CameraType cameraType = CameraType.back;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  // lifecycle対応
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    cameras ??= await availableCameras();

    final controller = CameraController(
      getCurrentCamera(),
      ResolutionPreset.veryHigh,
      enableAudio: true,
    );

    await controller.initialize();

    if (!mounted) return;

    _controller = controller;
    setState(() {});
  }

  Future<void> _switchCamera() async {
    final oldController = _controller;

    _controller = null;
    setState(() {});

    await oldController?.dispose();

    cameraType = cameraType == CameraType.back
        ? CameraType.front
        : CameraType.back;

    await _initCamera();
  }

  Future<void> takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    final file = await _controller!.takePicture();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraPreviewScreen(imagePath: file.path),
      ),
    );
  }

  Future<void> startVideo() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.startVideoRecording();

      setState(() {
        isRecording = true;
      });
    } catch (e) {
      debugPrint("Start video error: $e");
    }
  }

  Future<void> stopVideo() async {
    if (_controller == null) return;
    final file = await _controller!.stopVideoRecording();
    try {

      debugPrint("Video saved: ${file.path}");

      setState(() {
        isRecording = false;
      });
    } catch (e) {
      debugPrint("Stop video error: $e");
    }

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPreviewScreen(videoPath: file.path),
      ),
    );
  }

  CameraDescription getCurrentCamera() {
    return cameras!.firstWhere(
      (camera) =>
          camera.lensDirection ==
          (cameraType == CameraType.back
              ? CameraLensDirection.back
              : CameraLensDirection.front),
    );
  }

  Widget buildPreview() {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return CameraPreview(_controller!);
  }

  Widget buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isVideoMode = false;
                  });
                },
                child: const Text("PHOTO"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isVideoMode = true;
                  });
                },
                child: const Text("VIDEO"),
              ),
              TextButton(onPressed: _switchCamera, child: const Text("SWITCH")),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              if (isVideoMode) {
                if (isRecording) {
                  stopVideo();
                } else {
                  startVideo();
                }
              } else {
                takePhoto();
              }
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isVideoMode ? Colors.red : Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [buildPreview(), buildControls()]));
  }
}
