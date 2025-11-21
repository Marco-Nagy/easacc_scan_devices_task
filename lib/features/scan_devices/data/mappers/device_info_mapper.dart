import 'package:easacc_scan_devices_task/features/scan_devices/data/models/device_info_response.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wifi_scan/wifi_scan.dart';

class DeviceInfoMapper {
  static NetworkDevice toDomain(DeviceInfoResponse dto) {
    return NetworkDevice(
      id: dto.id,
      name: dto.name,
      type: dto.type,
      rssi: dto.rssi,
      manufacturer: dto.manufacturer,
      services: dto.services,
    );
  }

  static DeviceInfoResponse toResponse(NetworkDevice dto) {
    return DeviceInfoResponse(
      id: dto.id,
      name: dto.name,
      type: dto.type,
      rssi: dto.rssi,
      manufacturer: dto.manufacturer,
      services: dto.services,
    );
  }

  static List<NetworkDevice> bluetoothToDomainList(
      List<ScanResult> scanResults,
      ) {
    final uniqueById = <String, ScanResult>{};

    for (final r in scanResults) {
      uniqueById[r.device.remoteId.str] = r;
    }

    return uniqueById.values.map((scan) {
      final device = scan.device;
      final adv = scan.advertisementData;

      final name = _resolveDeviceName(
        deviceName: adv.advName,
        platformName: device.platformName,
        id: device.remoteId.str,
      );

      return NetworkDevice(
        id: device.remoteId.str,
        name: name,
        type: DeviceType.bluetooth,
        rssi: scan.rssi,
      );
    }).toList();
  }

  static List<NetworkDevice> wifiToDomainList(
      List<WiFiAccessPoint> scanResults,
      ) {
    final uniqueById = <String, WiFiAccessPoint>{};

    for (final r in scanResults) {
      final id = r.bssid;
      uniqueById[id] = r;
    }

    return uniqueById.values.map((scan) {
      final id = scan.bssid ?? scan.ssid;

      final name = _resolveDeviceName(
        deviceName: scan.ssid,
        platformName: '', // عدّلها لو عندك field فعلي
        id: id,
      );

      return NetworkDevice(
        id: id,
        name: name,
        type: DeviceType.wifi,
        rssi: scan.level,
      );
    }).toList();
  }

  static String _resolveDeviceName({
    required String deviceName,
    required String platformName,
    required String id,
  }) {
    if (deviceName.isNotEmpty) return deviceName;
    if (platformName.isNotEmpty) return platformName;
    return id;
  }
}
