import 'dart:async';
import 'package:flutter/material.dart';
import 'staff_model.dart';
import 'staff_roll_service.dart';

class StaffRollScreen extends StatefulWidget {

  const StaffRollScreen({super.key});

  @override
  State<StaffRollScreen> createState() => _StaffRollScreenState();
}

class _StaffRollScreenState extends State<StaffRollScreen> {
  final ScrollController _scrollController = ScrollController();
  final StaffRollService _service = StaffRollService();

  List<Staff> _staffs = [];
  bool _loading = true;

  Timer? _timer;

  Future<void> _init() async {
    _staffs = await _service.loadStaffs();
    _service.playBgm('audio/bgm.mp3');

    setState(() {
      _loading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _startAutoScroll() {
    const speed = 1.0;
    const interval = Duration(milliseconds: 16);

    _timer = Timer.periodic(interval, (timer) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.offset + speed);

        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _service.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () async {
            _timer?.cancel();
            await _service.stopBgm();
            if (mounted) Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: Column(
            children: [
              const SizedBox(height: 400),
              for (final staff in _staffs) ...[
                _TitleText(staff.title),
                const SizedBox(height: 16),
                _NameText(staff.name),
                const SizedBox(height: 80),
              ],
              const SizedBox(height: 600),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _NameText extends StatelessWidget {
  final String text;

  const _NameText(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
