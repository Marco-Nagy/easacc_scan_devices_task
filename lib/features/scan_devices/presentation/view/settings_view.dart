import 'package:easacc_scan_devices_task/core/utils/routing/app_router.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/presentation/viewModel/scan_devices_view_model.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/presentation/widget/devices_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:easacc_scan_devices_task/features/scan_devices/domain/entities/network_device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _urlController = TextEditingController();
  NetworkDevice? _selectedDevice;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  String _normalizeUrl(String url) {
    url = url.trim();
    if (url.isEmpty) return url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  void _openWebScreen() {
    final raw = _urlController.text.trim();
    if (raw.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a URL first')));
      return;
    }

    final url = _normalizeUrl(raw);
    context.goNamed(AppRouter.webScreenView, extra: url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            const Icon(Icons.settings),
            const SizedBox(width: 8),
            const Text('Settings Screen'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // URL input
            const Text(
              'Web URL',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  // Add this
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'https://example.com',
                    ),
                    keyboardType: TextInputType.url,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _openWebScreen,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('Go'), Icon(Icons.arrow_forward)],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Devices dropdown (Wi-Fi + Bluetooth)
            DevicesDropdown(
              label: 'Select printer / network device',
              initialValue: _selectedDevice,
              onChanged: (NetworkDevice? device) {
                if (device != null) {
                  context.read<ScanDevicesViewModel>().selectDevice(device);
                }
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
