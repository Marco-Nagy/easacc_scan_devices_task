import 'package:easacc_scan_devices_task/core/services/device_enable_service.dart';
import 'package:easacc_scan_devices_task/di/di.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/presentation/viewModel/scan_devices_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DevicesDropdown extends StatelessWidget {
  final NetworkDevice? initialValue;
  final ValueChanged<NetworkDevice?>? onChanged;
  final String label;

  const DevicesDropdown({
    super.key,
    this.initialValue,
    this.onChanged,
    this.label = 'Select device (Wi-Fi / Bluetooth)',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanDevicesViewModel>(
      create: (_) => getIt<ScanDevicesViewModel>()..scanDevices(),
      child: BlocBuilder<ScanDevicesViewModel, ScanDevicesState>(
        builder: (context, state) {
          final viewModel = context.read<ScanDevicesViewModel>();

          switch (state) {
            case ScanDevicesInitial():
            case ScanDevicesLoading():
              return const Center(child: CircularProgressIndicator());

            case ScanDevicesSuccess():
              final devices = state.devices;
              if (devices.isEmpty) {
                return _buildEmptyState(viewModel, context);
              }
              return _buildSuccessState(viewModel, state);

            case ScanDevicesFailure():
              return _buildErrorState(state, viewModel, context);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(
      ScanDevicesFailure state,
      ScanDevicesViewModel viewModel,
      BuildContext context,
      ) {
    final deviceEnableService = getIt<DeviceEnableService>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: viewModel.scanDevices,
              child: Row(
                children: [
                  const Text('Retry scan'),
                  const SizedBox(width: 8),
                  const Icon(Icons.refresh),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final bluetoothEnabled = await deviceEnableService.isBluetoothEnabled();
                final wifiEnabled = await deviceEnableService.isWifiEnabled();
                
                await deviceEnableService.showEnableDevicesDialog(
                  context,
                  bluetoothEnabled: bluetoothEnabled,
                  wifiEnabled: wifiEnabled,
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Enable Devices'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuccessState(
      ScanDevicesViewModel viewModel,
      ScanDevicesSuccess state,
      ) {
    // 1) شيل أي duplicates بالـ id
    final devices = _uniqueDevicesById(state.devices);
    for (final d in state.devices) {
      debugPrint('Device: id=${d.id}, name=${d.name}, type=${d.type}');
    }


    // 2) اختار selected من نفس اللستة بعد التنضيف
    final selected = _resolveSelectedDevice(
      initialValue,
      state.selectedDevice,
      devices,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<NetworkDevice>(
          initialValue: selected, // أهم حاجة: لازم يكون موجود جوّه devices
          items: devices.map((device) {
            return DropdownMenuItem<NetworkDevice>(
              value: device,
              child: Row(
                children: [
                  Icon(device.type.name.toLowerCase() == 'bluetooth' ? Icons.bluetooth : Icons.wifi,
                  color: device.type.name.toLowerCase() == 'bluetooth' ? Colors.blue : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${device.name} (${device.rssi.toString()})',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.selectDevice(value);
            }
            onChanged?.call(value);
          },
        ),

      ],
    );
  }

  List<NetworkDevice> _uniqueDevicesById(List<NetworkDevice> devices) {
    final map = <String, NetworkDevice>{};
    for (final d in devices) {
      map[d.id] = d; // لو نفس id تاني، الأخير هو اللي يفضل
    }
    return map.values.toList();
  }

  NetworkDevice? _resolveSelectedDevice(
      NetworkDevice? initial,
      NetworkDevice? fromState,
      List<NetworkDevice> devices,
      ) {
    final candidate = initial ?? fromState;
    if (candidate == null) return null;

    // دور على device بنفس الـ id جوّه اللستة بعد التنضيف
    try {
      return devices.firstWhere((d) => d.id == candidate.id);
    } catch (_) {
      return null;
    }
  }


  Widget _buildEmptyState(ScanDevicesViewModel viewModel, BuildContext context) {
    final deviceEnableService = getIt<DeviceEnableService>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('No devices found.'),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: viewModel.scanDevices,
              child: const Text('Scan again'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final bluetoothEnabled = await deviceEnableService.isBluetoothEnabled();
                final wifiEnabled = await deviceEnableService.isWifiEnabled();
                
                await deviceEnableService.showEnableDevicesDialog(
                  context,
                  bluetoothEnabled: bluetoothEnabled,
                  wifiEnabled: wifiEnabled,
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Enable Devices'),
            ),
          ],
        ),
      ],
    );
  }
}
