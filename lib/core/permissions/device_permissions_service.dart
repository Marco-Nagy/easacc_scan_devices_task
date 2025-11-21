// lib/core/permissions/device_permissions_service.dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';

class DevicePermissionsService {
  const DevicePermissionsService();

  Future<bool> ensureBluetoothPermissions() async {
    if (kIsWeb) return false;
    if (!(Platform.isAndroid || Platform.isIOS)) return false;

    if (Platform.isAndroid) {
      final scan = await Permission.bluetoothScan.request();
      final connect = await Permission.bluetoothConnect.request();

      return scan.isGranted && connect.isGranted;
    }

    if (Platform.isIOS) {
      final bluetooth = await Permission.bluetooth.request();
      return bluetooth.isGranted;
    }

    return false;
  }

  Future<bool> ensureWifiScanPermissions() async {
    if (kIsWeb) return false;
    if (!(Platform.isAndroid || Platform.isIOS)) return false;

    if (Platform.isAndroid) {
      // في معظم الأجهزة Location هي اللي بتتحكّم في Wi-Fi scan
      final location = await Permission.locationWhenInUse.request();
      return location.isGranted;
    }

    if (Platform.isIOS) {
      final location = await Permission.locationWhenInUse.request();
      return location.isGranted;
    }

    return false;
  }
}
