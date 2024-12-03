// lib/common/permissions_helper.dart

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  /// Requests permission for a specific permission type.
  /// Returns a Future<bool> indicating whether the permission is granted.
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// Checks if a specific permission is granted.
  /// Returns a Future<bool> indicating whether the permission is granted.
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// Requests multiple permissions at once.
  /// Returns a Map of permission status with the permission as key and the status as value.
  static Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) async {
    final statuses = await Future.wait(
        permissions.map((permission) => permission.request()));
    return Map.fromIterables(permissions, statuses);
  }

  /// Checks if multiple permissions are granted.
  /// Returns a Map of permission status with the permission as key and the status as value.
  static Future<Map<Permission, PermissionStatus>> checkPermissions(
      List<Permission> permissions) async {
    final statuses =
        await Future.wait(permissions.map((permission) => permission.status));
    return Map.fromIterables(permissions, statuses);
  }

  /// Shows a dialog to explain why a permission is needed and request it.
  /// This method should be used if you want to explain to the user why a permission is necessary.
  static Future<void> showPermissionDialog(
      BuildContext context, Permission permission, String message) async {
    final isGranted = await isPermissionGranted(permission);
    if (!isGranted) {
      final bool shouldRequest = await _showDialog(context, message);
      if (shouldRequest) {
        await requestPermission(permission);
      }
    }
  }

  /// Helper method to show a dialog with a message and "Allow" and "Deny" buttons.
  static Future<bool> _showDialog(BuildContext context, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Permission Required'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Deny'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Allow'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

// Example usage
// Future<void> checkAndRequestLocationPermission(BuildContext context) async {
//   await PermissionsHelper.showPermissionDialog(
//     context,
//     Permission.location,
//     'This app needs location access to provide better services.',
//   );
// }

//Purpose: Manages requesting and handling permissions for different functionalities.
// Usage: Used to request and handle permissions for accessing device features.
