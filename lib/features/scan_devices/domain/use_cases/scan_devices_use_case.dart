import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/repositories/scan_devices_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScanDevicesUseCase {
  final ScanDevicesRepository _scanDevicesRepository;

  ScanDevicesUseCase(this._scanDevicesRepository);

  Future<List<NetworkDevice>> call() async {
  List<List<NetworkDevice>>  results = await Future.wait([
      _scanDevicesRepository.scanDevices(DeviceType.bluetooth),
      _scanDevicesRepository.scanDevices(DeviceType.wifi),
    ]);
  results[0].sort((a, b) => b.rssi!.compareTo(a.rssi!));
  results[1].sort((a, b) => b.rssi!.compareTo(a.rssi!));

    final devices = [...results[0], ...results[1]];
    return _sortDevices(devices);
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
