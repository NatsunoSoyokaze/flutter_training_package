import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_helper.dart'; // PermissionHelper のファイルを読み込む想定

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<bool> _checkPermission(
    BuildContext context,
    Permission permission,
  ) async {
    return await PermissionHelper.checkPermission(
      context: context,
      permission: permission,
      title: 'カメラ権限が必要です',
      message: '写真を撮影するにはカメラ権限が必要です。',
    );
  }

  /// 写真撮影（安全版：権限拒否時は null を返す）
  Future<File?> takePhotoSafe(BuildContext context) async {
    final hasPermission = await _checkPermission(context, Permission.camera);

    if (!hasPermission) {
      // 権限がない場合は null を返すだけ
      return null;
    }

    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    if (file == null) return null;

    return File(file.path);
  }

  /// 動画撮影（安全版：権限拒否時は null を返す）
  Future<File?> takeVideoSafe(
    BuildContext context, {
    Duration? maxDuration,
  }) async {
    final hasPermission = await _checkPermission(context, Permission.camera);

    if (!hasPermission) {
      return null;
    }

    final XFile? file = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: maxDuration,
    );
    if (file == null) return null;

    return File(file.path);
  }
}
