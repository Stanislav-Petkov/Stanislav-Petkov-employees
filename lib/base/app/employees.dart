// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../../l10n/l10n.dart';
import '../../lib_router/router.dart';
import '../data_sources/remote/http_clients/api_http_client.dart';
import '../data_sources/remote/http_clients/plain_http_client.dart';
import '../di/employees_with_dependencies.dart';
import '../theme/design_system.dart';
import '../theme/employees_theme.dart';
import 'config/environment_config.dart';

/// This widget is the root of your application.
class Employees extends StatelessWidget {
  const Employees({
    this.config = EnvironmentConfig.production,
    Key? key,
  }) : super(key: key);

  final EnvironmentConfig config;

  @override
  Widget build(BuildContext context) => EmployeesWithDependencies(
        config: config,
        child: const _MyMaterialApp(),
      );
}

/// Wrapper around the MaterialApp widget to provide additional functionality
/// accessible throughout the app (such as App-level dependencies, Firebase
/// services, etc).
class _MyMaterialApp extends StatefulWidget {
  const _MyMaterialApp();

  @override
  __MyMaterialAppState createState() => __MyMaterialAppState();
}

class __MyMaterialAppState extends State<_MyMaterialApp> {
  Locale? _locale;

  @override
  void initState() {
    _locale = const Locale('en');

    _configureInterceptors();
    super.initState();
  }

  void _configureInterceptors() {
    context.read<PlainHttpClient>().configureInterceptors();

    context.read<ApiHttpClient>().configureInterceptors();
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = _buildMaterialApp(context);

    return materialApp;
  }

  Widget _buildMaterialApp(BuildContext context) => MaterialApp.router(
        title: 'Employees',
        theme: EmployeesTheme.buildTheme(DesignSystem.light()),
        darkTheme: EmployeesTheme.buildTheme(DesignSystem.dark()),
        localizationsDelegates: const [
          I18n.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: I18n.supportedLocales,
        locale: _locale,
        routerConfig: context.read<AppRouter>().router,
        debugShowCheckedModeBanner: false,
      );
}
