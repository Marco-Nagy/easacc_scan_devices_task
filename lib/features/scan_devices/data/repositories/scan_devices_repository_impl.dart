import "package:easacc_scan_devices_task/features/scan_devices/data/data_sources/bluetooth_service_data_source.dart";
import "package:easacc_scan_devices_task/features/scan_devices/data/data_sources/wifi_service_data_source.dart";
import "package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart";
import "package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart";
import "package:injectable/injectable.dart";

import "../../domain/repositories/scan_devices_repository.dart";
@Injectable(as:ScanDevicesRepository )
class ScanDevicesRepositoryImpl implements ScanDevicesRepository {
  final BluetoothServiceDataSource _bluetoothServiceDataSource;
  final WifiServiceDataSource _wifiDeviceDataSource;

  ScanDevicesRepositoryImpl(this._bluetoothServiceDataSource,this._wifiDeviceDataSource);

  @override
  Future<List<NetworkDevice>> scanDevices(DeviceType deviceType) async {
switch(deviceType){
  case DeviceType.bluetooth:
    return await _bluetoothServiceDataSource.scanDevices();
  case DeviceType.wifi:
    return await _wifiDeviceDataSource.scanDevices();
  case DeviceType.unknown:
    return [];
}
  }
}
