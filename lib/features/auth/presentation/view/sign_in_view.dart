// lib/features/auth/presentation/view/sign_in_page.dart
import 'package:easacc_scan_devices_task/core/utils/routing/app_router.dart';
import 'package:easacc_scan_devices_task/core/utils/routing/go_router_x.dart';
import 'package:easacc_scan_devices_task/di/di.dart';
import 'package:easacc_scan_devices_task/features/auth/presentation/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_provider_type.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late AuthViewModel _authCubit;

  @override
  void initState() {
    _authCubit = getIt<AuthViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthViewModel>(

      create: (_) => getIt<AuthViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Social Login')),
        body: Center(
          child: BlocConsumer<AuthViewModel, AuthState>(
            bloc: _authCubit,
            listener: (context, state) {
              if (state is AuthInitial) {
                debugPrint('ssssssssss ${state.runtimeType}');
              }
              if (state is AuthLoading) {
                debugPrint('ddddddddd ${state.runtimeType}');
              }
              if (state is AuthSuccess) {
                context.replaceNamedSafe(AppRouter.settingsView,);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Signed in as ${state.user.email ?? state.user.name}',
                    ),
                  ),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              switch (state) {
                case AuthInitial():
                case AuthLoading():
                  // return const Center(child: CircularProgressIndicator());
                case AuthSuccess():
                case AuthFailure():
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.g_mobiledata),
                      label: const Text('Sign in with Google'),
                      onPressed: state is AuthLoading
                          ? null
                          : () => _authCubit.signIn(AuthProviderType.google),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.facebook),
                      label: const Text('Sign in with Facebook'),
                      onPressed: state is AuthLoading
                          ? null
                          : () =>
                          _authCubit.signIn(AuthProviderType.facebook),
                    ),
                  ],
                );

              }
            },
          ),
        ),
      ),
    );
  }
}
