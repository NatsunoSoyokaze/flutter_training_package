import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:nfc/package/service/staff_roll/staff_model.dart';

class StaffRollService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playBgm(String assetPath) async {
    await _player.play(AssetSource(assetPath));
  }

  Future<void> stopBgm() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  Future<List<Staff>> loadStaffs() async {
    final String jsonString =
    await rootBundle.loadString('assets/staff/staffs.json');

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((e) => Staff.fromJson(e)).toList();
  }
}