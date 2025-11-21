import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_provider_type.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_user.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<AuthUser> call(AuthProviderType provider) async {
    return await _authRepository.signIn(provider);
  }

}
