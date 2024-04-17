import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  GetPermission._();

  static Future<bool> checkPermission({required Permission permission}) async {
    try {
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus.isGranted) {
        log('Permission is granted');
        return true;
      } else if (permissionStatus.isDenied || permissionStatus.isRestricted) {
        log('Permission is denied or restricted');
        return await requestPermission(permission);
      } else if (permissionStatus.isPermanentlyDenied) {
        log('Permission is permanently denied');
        return false;
      } else if (permissionStatus.isLimited) {
        log('Permission is limited');
        return true;
      }
      return false;
    } catch (e) {
      log('Error checking permission: $e');
      return false;
    }
  }

  static Future<bool> requestPermission(Permission permission) async {
    try {
      PermissionStatus permissionStatus = await permission.request();
      if (permissionStatus.isGranted) {
        log('Permission is granted');
        return true;
      } else {
        log('Permission is denied');
        return false;
      }
    } catch (e) {
      log('Error requesting permission: $e');
      return false;
    }
  }
}
