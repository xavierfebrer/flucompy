import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static void requestPermissions(List<PermissionGroup> permissionGroup, Function(Map<PermissionGroup, PermissionStatus>) onPermissionsResult) {
    PermissionHandler().requestPermissions(permissionGroup).then((ignored) {
      onPermissionsResult(ignored);
    });
  }

  static void checkPermissionStatus(PermissionGroup permissionGroup, Function(PermissionStatus) onPermissionStatus) {
    PermissionHandler().checkPermissionStatus(permissionGroup).then((status) {
      onPermissionStatus(status);
    });
  }

  static void openAppSettings([Function(bool) onAppSettingsOpened]) {
    PermissionHandler().openAppSettings().then((opened) {
      if (onAppSettingsOpened != null) {
        onAppSettingsOpened(opened);
      }
    });
  }
}
