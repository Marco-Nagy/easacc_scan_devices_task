import "package:easacc_scan_devices_task/features/auth/data/data_sources/contracts/facebook_auth_data_source.dart";
import "package:easacc_scan_devices_task/features/auth/data/data_sources/contracts/google_auth_data_source.dart";
import "package:easacc_scan_devices_task/features/auth/data/mappers/auth_mappers.dart";
import "package:easacc_scan_devices_task/features/auth/domain/entities/auth_provider_type.dart";
import "package:easacc_scan_devices_task/features/auth/domain/entities/auth_user.dart";
import "package:injectable/injectable.dart";

import "../../domain/repositories/auth_repository.dart";

@Injectable( as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthDataSource _googleAuthDataSource;
  final FacebookAuthDataSource _facebookAuthDataSource;

  AuthRepositoryImpl({
    required GoogleAuthDataSource googleAuthDataSource,
    required FacebookAuthDataSource facebookAuthDataSource,
  })  : _googleAuthDataSource = googleAuthDataSource,
        _facebookAuthDataSource = facebookAuthDataSource;

  @override
  Future<AuthUser> signIn(AuthProviderType provider)async {
    switch (provider) {
      case AuthProviderType.google:
        final response = await _googleAuthDataSource.signIn();
        return response!.toDomain();
      case AuthProviderType.facebook:

        final response = await _facebookAuthDataSource.signIn();
        return response.toDomain();
    }
  }
}

