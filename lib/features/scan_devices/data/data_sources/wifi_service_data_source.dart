import 'dart:io' show Platform;

import 'package:easacc_scan_devices_task/core/permissions/device_permissions_service.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/data/mappers/device_info_mapper.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:injectable/injectable.dart';
import 'package:wifi_scan/wifi_scan.dart';


@lazySingleton
class WifiServiceDataSource {
  final DevicePermissionsService _permissions;

  const WifiServiceDataSource(this._permissions);

  Future<List<NetworkDevice>> scanDevices() async {
    debugPrint('🔵 [WiFi] Starting scan...');
    
    if (!_isPlatformSupported) {
      debugPrint('🔴 [WiFi] Platform not supported');
      return const [];
    }
    
    final hasPermission = await _permissions.ensureWifiScanPermissions();
    if (!hasPermission) {
      debugPrint('🔴 [WiFi] Permission denied');
      return const [];
    }
    debugPrint('✅ [WiFi] Permissions granted');

    final canGetResults = await WiFiScan.instance.canGetScannedResults();
    debugPrint('🔵 [WiFi] canGetScannedResults status: $canGetResults');
    
    if (canGetResults != CanGetScannedResults.yes) {
      debugPrint('🔴 [WiFi] Cannot get scanned results. Status: $canGetResults');
      if (Platform.isIOS) {
        debugPrint('⚠️ [WiFi] Note: iOS has limited WiFi scanning capabilities due to platform restrictions');
      }
      return const [];
    }
    debugPrint('✅ [WiFi] Can get scanned results');

    if (!await _canStartScan()) {
      debugPrint('🔴 [WiFi] Cannot start scan');
      return const [];
    }
    debugPrint('✅ [WiFi] Can start scan');

    debugPrint('🔵 [WiFi] Performing scan...');
    final accessPoints = await _performScan();
    debugPrint('✅ [WiFi] Scan completed: ${accessPoints.length} access points found');
    
    final devices = DeviceInfoMapper.wifiToDomainList(accessPoints);
    debugPrint('✅ [WiFi] Mapped to ${devices.length} network devices');
    return devices;
  }

  // ------------ helpers ------------

  bool get _isPlatformSupported {
    return (Platform.isAndroid || Platform.isIOS);
  }

  Future<bool> _isWifiScanSupported() async {
    final can = await WiFiScan.instance.canGetScannedResults();
    debugPrint('🔵 [WiFi] canGetScannedResults: $can');
    return can == CanGetScannedResults.yes;
  }

  Future<bool> _canStartScan() async {
    final can = await WiFiScan.instance.canStartScan();
    debugPrint('🔵 [WiFi] canStartScan: $can');
    return can == CanStartScan.yes;
  }

  Future<List<WiFiAccessPoint>> _performScan() async {
    try {
      debugPrint('🔵 [WiFi] Starting scan...');
      final startResult = await WiFiScan.instance.startScan();
      debugPrint('🔵 [WiFi] startScan result: $startResult');
      
      if (startResult != true) {
        debugPrint('🔴 [WiFi] startScan failed');
        return [];
      }
      
      // Wait a bit for scan to complete
      await Future.delayed(const Duration(milliseconds: 500));
      
      debugPrint('🔵 [WiFi] Getting scanned results...');
      final results = await WiFiScan.instance.getScannedResults();
      debugPrint('🔵 [WiFi] getScannedResults returned ${results.length} items');
      
      return results;
    } catch (e) {
      debugPrint('🔴 [WiFi] Error during scan: $e');
      return [];
    }
  }


}
