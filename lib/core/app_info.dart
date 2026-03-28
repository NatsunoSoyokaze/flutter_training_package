import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static String _version = "";
  static String _buildNumber = "";

  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    _version = info.version;
    _buildNumber = info.buildNumber;
  }

  static String get version => _version;

  static String get buildNumber => _buildNumber;

  static String get fullVersion => "v$_version ($_buildNumber)";

  static Future<String> getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return "v${info.version} (${info.buildNumber})";
  }
}
