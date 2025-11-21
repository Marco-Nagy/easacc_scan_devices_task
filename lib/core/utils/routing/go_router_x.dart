// lib/navigation/go_router_extension.dart
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension GoRouterX on BuildContext {
  /// go to plain location: context.goTo('/trips');
  void goTo(String location) {
    GoRouter.of(this).go(location);
  }

  /// push new page: context.pushTo('/trips/42');
  void pushTo(String location) {
    GoRouter.of(this).push(location);
  }

  /// go by name safely (ignores nulls)
  ///
  /// usage:
  /// context.goNamedSafe(AppRoutes.taskDetails,
  ///   pathParams: {'id': taskId},
  ///   queryParams: {'tab': 'reports'},
  /// );
  void goNamedSafe(
      String name, {
        Map<String, String>? pathParams,
        Map<String, String>? queryParams,
        Object? extra,
      }) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParams ?? const {},
      queryParameters: queryParams ?? const {},
      extra: extra,
    );
  }

  /// push by name
  void pushNamedSafe(
      String name, {
        Map<String, String>? pathParams,
        Map<String, String>? queryParams,
        Object? extra,
      }) {
    GoRouter.of(this).pushNamed(
      name,
      pathParameters: pathParams ?? const {},
      queryParameters: queryParams ?? const {},
      extra: extra,
    );
  }

  /// replace current route
  void replaceNamedSafe(
      String name, {
        Map<String, String>? pathParams,
        Map<String, String>? queryParams,
        Object? extra,
      }) {
    GoRouter.of(this).replaceNamed(
      name,
      pathParameters: pathParams ?? const {},
      queryParameters: queryParams ?? const {},
      extra: extra,
    );
  }

  /// go back if possible
  void popRoute() {
    GoRouter.of(this).pop();

    if (GoRouter.of(this).canPop()) {
    }
  }
}
