import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_provider_type.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthUser> signIn(AuthProviderType provider);
}
