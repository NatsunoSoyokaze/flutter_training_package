import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfc/package/service/permission_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<bool> _checkPermission(
    BuildContext context,
    Permission permission,
    String title,
    String message,
  ) async {
    return await PermissionHelper.checkPermission(
      context: context,
      permission: permission,
      title: title,
      message: message,
    );
  }

  /// 現在位置を取得（権限もまとめて処理）
  Future<Position?> getCurrentLocation(BuildContext context) async {
    // 位置情報サービスがONか確認
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _checkPermission(
        context,
        Permission.location,
        '位置情報サービスがオフです',
        '設定から位置情報サービスをONにしてください。',
      );
      return null;
    }

    // 権限確認
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _checkPermission(
          context,
          Permission.location,
          '権限拒否',
          '位置情報の利用が許可されていません。',
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _checkPermission(
        context,
        Permission.location,
        '権限永久拒否',
        '設定アプリから位置情報の権限を変更してください。',
      );
      return null;
    }

    AndroidSettings settings = AndroidSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 0,
    );

    // 位置情報取得
    return await Geolocator.getCurrentPosition(
      locationSettings: settings
    );
  }
}
