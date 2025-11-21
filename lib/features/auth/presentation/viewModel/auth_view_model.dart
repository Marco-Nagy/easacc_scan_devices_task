import 'package:bloc/bloc.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_provider_type.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_user.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
@injectable
class AuthViewModel extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;

  AuthViewModel(
      this._signInUseCase,
      ) : super(AuthInitial());

  Future<void> signIn(AuthProviderType provider) async {
    emit(AuthLoading());
    try {
      final user = await _signInUseCase(provider);
      emit(AuthSuccess(user: user));
    } catch (e) {
      debugPrint('🔴 AuthViewModel Error: $e');
      emit(AuthFailure(message: e.toString()));
    }
  }
}
