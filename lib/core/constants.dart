import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app_info.dart';

/// 定数系をまとまたもの
class Constants {

  /// アプリケーションのバージョンを取得
  static Future<String> getApplicationVersion() async {
    PackageInfo platform = await PackageInfo.fromPlatform();
    return platform.version;
  }
}