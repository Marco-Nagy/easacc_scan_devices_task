// lib/features/scan_devices/data/models/device_info_response.dart
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';

class DeviceInfoResponse {
  final String id;            // remoteId / bssid / unique id
  final String name;          // SSID or BT name
  final DeviceType type;      // wifi | bluetooth
  final int? rssi;            // signal strength
  final String? manufacturer; // manufacturer name if available
  final List<String>? services; // service UUIDs for BT

  const DeviceInfoResponse({
    required this.id,
    required this.name,
    required this.type,
    this.rssi,
    this.manufacturer,
    this.services,
  });

  factory DeviceInfoResponse.empty() {
    return const DeviceInfoResponse(
      id: '',
      name: '',
      type: DeviceType.unknown,
      rssi: null,
      manufacturer: null,
      services: null,
    );
  }
}
