// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i806;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/common/core_module.dart' as _i285;
import '../core/permissions/device_permissions_service.dart' as _i1071;
import '../features/auth/data/data_sources/contracts/facebook_auth_data_source.dart'
    as _i684;
import '../features/auth/data/data_sources/contracts/google_auth_data_source.dart'
    as _i901;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/use_cases/sign_in_use_case.dart' as _i503;
import '../features/auth/presentation/viewModel/auth_view_model.dart' as _i726;
import '../features/scan_devices/data/data_sources/bluetooth_service_data_source.dart'
    as _i762;
import '../features/scan_devices/data/data_sources/wifi_service_data_source.dart'
    as _i332;
import '../features/scan_devices/data/repositories/scan_devices_repository_impl.dart'
    as _i1034;
import '../features/scan_devices/domain/repositories/scan_devices_repository.dart'
    as _i864;
import '../features/scan_devices/domain/use_cases/scan_devices_use_case.dart'
    as _i229;
import '../features/scan_devices/presentation/viewModel/scan_devices_view_model.dart'
    as _i564;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreModule = _$CoreModule();
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => coreModule.navigatorKey,
    );
    gh.lazySingleton<_i1071.DevicePermissionsService>(
      () => coreModule.devicePermissionsService,
    );
    gh.lazySingleton<_i806.FacebookAuth>(() => coreModule.facebookAuth);
    gh.lazySingleton<_i901.GoogleAuthDataSource>(
      () => _i901.GoogleAuthDataSource(),
    );
    gh.lazySingleton<_i684.FacebookAuthDataSource>(
      () =>
          _i684.FacebookAuthDataSource(facebookAuth: gh<_i806.FacebookAuth>()),
    );
    gh.factory<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(
        googleAuthDataSource: gh<_i901.GoogleAuthDataSource>(),
        facebookAuthDataSource: gh<_i684.FacebookAuthDataSource>(),
      ),
    );
    gh.lazySingleton<_i762.BluetoothServiceDataSource>(
      () => _i762.BluetoothServiceDataSource(
        gh<_i1071.DevicePermissionsService>(),
      ),
    );
    gh.lazySingleton<_i332.WifiServiceDataSource>(
      () => _i332.WifiServiceDataSource(gh<_i1071.DevicePermissionsService>()),
    );
    gh.factory<_i503.SignInUseCase>(
      () => _i503.SignInUseCase(gh<_i869.AuthRepository>()),
    );
    gh.factory<_i864.ScanDevicesRepository>(
      () => _i1034.ScanDevicesRepositoryImpl(
        gh<_i762.BluetoothServiceDataSource>(),
        gh<_i332.WifiServiceDataSource>(),
      ),
    );
    gh.factory<_i229.ScanDevicesUseCase>(
      () => _i229.ScanDevicesUseCase(gh<_i864.ScanDevicesRepository>()),
    );
    gh.factory<_i564.ScanDevicesViewModel>(
      () => _i564.ScanDevicesViewModel(gh<_i229.ScanDevicesUseCase>()),
    );
    gh.factory<_i726.AuthViewModel>(
      () => _i726.AuthViewModel(gh<_i503.SignInUseCase>()),
    );
    return this;
  }
}

class _$CoreModule extends _i285.CoreModule {}
