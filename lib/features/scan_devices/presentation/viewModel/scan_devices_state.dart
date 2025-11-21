part of 'scan_devices_view_model.dart';

abstract class ScanDevicesState extends Equatable {
  const ScanDevicesState();

  @override
  List<Object?> get props => [];
}

class ScanDevicesInitial extends ScanDevicesState {
  const ScanDevicesInitial();
}

class ScanDevicesLoading extends ScanDevicesState {
  const ScanDevicesLoading();
}

class ScanDevicesSuccess extends ScanDevicesState {
  final List<NetworkDevice> devices;
  final NetworkDevice? selectedDevice;

  const ScanDevicesSuccess({
    required this.devices,
    this.selectedDevice,
  });

  @override
  List<Object?> get props => [devices, selectedDevice];
}

class ScanDevicesFailure extends ScanDevicesState {
  final String message;

  const ScanDevicesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
