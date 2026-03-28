import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nfc/package/service/permission_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  /// プラットフォーム別に適切な権限を取得
  Permission _getPermission() {
    if (Platform.isIOS) {
      return Permission.photos;
    } else {
      return Permission.photos;
      // permission_handler 11系では Android13+ も photos でOK
      // 旧OS対応するなら Permission.storage を使う
    }
  }

  /// ギャラリーから画像取得
  Future<File?> pickImage(BuildContext context) async {
    final permission = _getPermission();

    final hasPermission = await PermissionHelper.checkPermission(
      context: context,
      permission: permission,
      title: '写真アクセスが必要です',
      message: '設定画面から写真アクセスを許可してください。',
    );

    if (!hasPermission) return null;

    try {
      final XFile? image =
      await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      debugPrint('画像取得エラー: $e');
      return null;
    }
  }
}