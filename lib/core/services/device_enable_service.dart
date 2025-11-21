// lib/core/services/device_enable_service.dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class DeviceEnableService {
  const DeviceEnableService();

  /// Check if Bluetooth adapter is enabled
  Future<bool> isBluetoothEnabled() async {
    if (kIsWeb) return false;
    if (!(Platform.isAndroid || Platform.isIOS)) return false;

    try {
      final state = await FlutterBluePlus.adapterState.first;
      return state == BluetoothAdapterState.on;
    } catch (e) {
      debugPrint('🔴 Error checking Bluetooth state: $e');
      return false;
    }
  }

  /// Check if WiFi is enabled (approximate check)
  Future<bool> isWifiEnabled() async {
    if (kIsWeb) return false;
    if (!(Platform.isAndroid || Platform.isIOS)) return false;

    // Note: Direct WiFi state check is limited on iOS
    // This is an approximation - actual WiFi scanning will reveal the real state
    return true;
  }

  /// Open device settings
  Future<bool> openSettings() async {
    if (kIsWeb) return false;
    return await openAppSettings();
  }

  /// Show dialog to enable Bluetooth
  Future<bool?> showEnableBluetoothDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.bluetooth, color: Colors.blue),
            SizedBox(width: 8),
            Text('Enable Bluetooth'),
          ],
        ),
        content: const Text(
          'Bluetooth is required to scan for nearby devices. '
          'Please enable Bluetooth in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Show dialog to enable WiFi
  Future<bool?> showEnableWifiDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.wifi, color: Colors.green),
            SizedBox(width: 8),
            Text('Enable WiFi'),
          ],
        ),
        content: const Text(
          'WiFi is required to scan for nearby networks. '
          'Please enable WiFi in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Show dialog for both Bluetooth and WiFi
  Future<bool?> showEnableDevicesDialog(
    BuildContext context, {
    required bool bluetoothEnabled,
    required bool wifiEnabled,
  }) async {
    if (bluetoothEnabled && wifiEnabled) return true;

    final missingDevices = <String>[];
    if (!bluetoothEnabled) missingDevices.add('Bluetooth');
    if (!wifiEnabled) missingDevices.add('WiFi');

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            if (!bluetoothEnabled) const Icon(Icons.bluetooth, color: Colors.blue),
            if (!bluetoothEnabled && !wifiEnabled) const SizedBox(width: 8),
            if (!wifiEnabled) const Icon(Icons.wifi, color: Colors.green),
            const SizedBox(width: 8),
            Text('Enable ${missingDevices.join(' & ')}'),
          ],
        ),
        content: Text(
          '${missingDevices.join(' and ')} ${missingDevices.length > 1 ? 'are' : 'is'} required to scan for nearby devices. '
          'Please enable ${missingDevices.join(' and ')} in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}

