// lib/common/utils/permission_utils.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> hasCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
