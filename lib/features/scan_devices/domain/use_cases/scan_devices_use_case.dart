import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/repositories/scan_devices_repository.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:injectable/injectable.dart';

@injectable
class ScanDevicesUseCase {
  final ScanDevicesRepository _scanDevicesRepository;

  ScanDevicesUseCase(this._scanDevicesRepository);

  Future<List<NetworkDevice>> call() async {
    debugPrint('🔵 [UseCase] Starting device scan...');
    
    List<List<NetworkDevice>>  results = await Future.wait([
      _scanDevicesRepository.scanDevices(DeviceType.bluetooth),
      _scanDevicesRepository.scanDevices(DeviceType.wifi),
    ]);
  
    debugPrint('🔵 [UseCase] Bluetooth devices: ${results[0].length}, WiFi devices: ${results[1].length}');
  
    // Create mutable copies before sorting to avoid "Cannot modify an unmodifiable list" error
    final bluetoothDevices = List<NetworkDevice>.from(results[0]);
    final wifiDevices = List<NetworkDevice>.from(results[1]);
  
    bluetoothDevices.sort((a, b) => (b.rssi ?? 0).compareTo(a.rssi ?? 0));
    wifiDevices.sort((a, b) => (b.rssi ?? 0).compareTo(a.rssi ?? 0));

    final devices = [...bluetoothDevices, ...wifiDevices];
    final sorted = _sortDevices(devices);
    debugPrint('✅ [UseCase] Total devices after sorting: ${sorted.length}');
    return sorted;
  }

  List<NetworkDevice> _sortDevices(List<NetworkDevice> devices) {
    final sorted = [...devices];

    sorted.sort((a, b) {
      final typeCompare = a.type.index.compareTo(b.type.index);
      if (typeCompare != 0) return typeCompare;

      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return sorted;
  }

}
