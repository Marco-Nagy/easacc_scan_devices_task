// lib/features/scan_devices/domain/entities/network_device.dart
import 'device_type.dart';

class NetworkDevice {
  final String id;
  final String name;
  final DeviceType type;
  final int? rssi;
  final String? manufacturer;
  final List<String>? services;

  const NetworkDevice({
    required this.id,
    required this.name,
    required this.type,
    this.rssi,
    this.manufacturer,
    this.services,
  });
}
