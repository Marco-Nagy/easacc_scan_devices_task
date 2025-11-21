import 'package:easacc_scan_devices_task/features/auth/presentation/view/sign_in_view.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/presentation/view/settings_view.dart';
import 'package:easacc_scan_devices_task/features/scan_devices/presentation/view/web_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static const root = 'root';
  static const settingsView = 'settingsView';
  static const webScreenView = 'webScreenView';


  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: root,
        path: '/',
        builder: (context, state) => const SignInView(),
      ),

      GoRoute(
        name: settingsView,
        path: '/settingsView',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        name: webScreenView,
        path: '/webScreenView',
        builder: (context, state) {
          final url = state.extra as String? ?? '';
          return  WebScreenView(url: url ,);
        },
      ),
    ],
  );
}
