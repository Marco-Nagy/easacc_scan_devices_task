// lib/features/scan_devices/data/data_sources/bluetooth_service_data_source.dart
import 'dart:io' show Platform;

import 'package:easacc_scan_devices_task/core/permissions/device_permissions_service.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/data/mappers/device_info_mapper.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BluetoothServiceDataSource {
  final DevicePermissionsService _permissions;

  BluetoothServiceDataSource(this._permissions);

  Future<List<NetworkDevice>> scanDevices() async {
    if (!_isPlatformSupported) return const [];

    final hasPermission = await _permissions.ensureBluetoothPermissions();
    if (!hasPermission) return const [];

    if (!await _isBluetoothSupported()) return const [];
    if (!await _isAdapterOn()) return const [];

    final scanResults = await _performScan();
    return DeviceInfoMapper.bluetoothToDomainList(scanResults);
  }

  bool get _isPlatformSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<bool> _isBluetoothSupported() async =>
      await FlutterBluePlus.isSupported;

  Future<bool> _isAdapterOn() async {
    final state = await FlutterBluePlus.adapterState.first;
    return state == BluetoothAdapterState.on;
  }

  Future<List<ScanResult>> _performScan() async {
    final collected = <ScanResult>[];

    final sub = FlutterBluePlus.onScanResults.listen((results) {
      collected.clear();
      collected.addAll(results);
    });

    FlutterBluePlus.cancelWhenScanComplete(sub);

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    await FlutterBluePlus.isScanning.where((v) => v == false).first;

    return collected;
  }
}
