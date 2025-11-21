import 'package:easacc_scan_devices_task/core/permissions/device_permissions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CoreModule {
  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
  @lazySingleton
  DevicePermissionsService get devicePermissionsService =>
      const DevicePermissionsService();
  @lazySingleton
  FacebookAuth get facebookAuth => FacebookAuth.instance;

}
