// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $employeesRoute,
    ];

RouteBase get $employeesRoute => GoRouteData.$route(
      path: '/employees',
      factory: $EmployeesRouteExtension._fromState,
    );

extension $EmployeesRouteExtension on EmployeesRoute {
  static EmployeesRoute _fromState(GoRouterState state) =>
      const EmployeesRoute();

  String get location => GoRouteData.$location(
        '/employees',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
