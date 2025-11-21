import 'package:easacc_scan_devices_task/core/utils/routing/app_router.dart';
import 'package:flutter/material.dart';

class EasaccScanDevicesApp extends StatelessWidget {
  const EasaccScanDevicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp.router(
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return Scaffold(
          backgroundColor:Colors.white,
          body: child,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
