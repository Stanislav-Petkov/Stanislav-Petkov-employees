// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'base/app/config/environment_config.dart';
import 'base/app/employees.dart';
import 'base/app/initialization/app_setup.dart';

/// Main entry point for the production environment
void main() async => await setupAndRunApp(
      (config) => Employees(
        config: config,
      ),
      environment: EnvironmentConfig.production,
    );
