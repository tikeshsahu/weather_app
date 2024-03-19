import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestLocationPermission() async {
    if (await Permission.location.isGranted) {
      // Permission is already granted
      return true;
    }

    // Request permission
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted
      return true;
    } else {
      // Permission denied
      // Handle accordingly (e.g., show an error message)
      return false;
    }
  }
}
