
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';

abstract  class ScanDevicesRepository {
  Future<List<NetworkDevice>> scanDevices( DeviceType deviceType);
}
