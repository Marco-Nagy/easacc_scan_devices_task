import 'package:bloc/bloc.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/device_type.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/use_cases/scan_devices_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'scan_devices_state.dart';
@injectable
class ScanDevicesViewModel extends Cubit<ScanDevicesState> {
  final ScanDevicesUseCase _scanDevicesUseCase;

  ScanDevicesViewModel(
      this._scanDevicesUseCase,
      ) : super(ScanDevicesInitial());

  Future<void> scanDevices() async {
    emit(ScanDevicesLoading());
    try {
      final devices = await _scanDevicesUseCase();
      emit(ScanDevicesSuccess(devices: devices));
    } catch (e) {
      emit(ScanDevicesFailure(message: e.toString()));
    }
  }
  void selectDevice(NetworkDevice device) {
    final current = state;
    if (current is ScanDevicesSuccess) {
      emit(ScanDevicesSuccess(
        devices: current.devices,
        selectedDevice: device,
      ));
    }
  }

}
