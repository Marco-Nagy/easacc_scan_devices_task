import 'dart:io' show Platform;

import 'package:easacc_scan_devices_task/core/permissions/device_permissions_service.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/data/mappers/device_info_mapper.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:injectable/injectable.dart';
import 'package:wifi_scan/wifi_scan.dart';


@lazySingleton
class WifiServiceDataSource {
  final DevicePermissionsService _permissions;

  const WifiServiceDataSource(this._permissions);

  Future<List<NetworkDevice>> scanDevices() async {
    if (!_isPlatformSupported) return const [];
    final hasPermission = await _permissions.ensureWifiScanPermissions();
    if (!hasPermission) return const [];

    if (!await _isWifiScanSupported()) return const [];

    if (!await _canStartScan()) return const [];

    final accessPoints = await _performScan();
    return DeviceInfoMapper.wifiToDomainList(accessPoints);
  }

  // ------------ helpers ------------

  bool get _isPlatformSupported {
    return (Platform.isAndroid || Platform.isIOS);
  }

  Future<bool> _isWifiScanSupported() async {
    final can = await WiFiScan.instance.canGetScannedResults();
    return can == CanGetScannedResults.yes;
  }

  Future<bool> _canStartScan() async {
    final can = await WiFiScan.instance.canStartScan();
    return can == CanStartScan.yes;
  }

  Future<List<WiFiAccessPoint>> _performScan() async {
    await WiFiScan.instance.startScan();
    final results = await WiFiScan.instance.getScannedResults();
    return results;
  }


}
