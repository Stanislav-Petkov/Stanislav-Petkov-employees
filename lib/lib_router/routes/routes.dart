part of '../router.dart';

@TypedGoRoute<EmployeesRoute>(path: RoutesPath.employees)
@immutable
class EmployeesRoute extends GoRouteData implements RouteDataModel {
  const EmployeesRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: const EmployeesPage(),
      );

  @override
  String get routeLocation => location;
}
