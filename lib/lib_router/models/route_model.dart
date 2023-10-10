// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'routes_path.dart';

enum RouteModel {
  employees(
    pathName: RoutesPath.employees,
    fullPath: '/employees',
  );

  final String pathName;
  final String fullPath;

  const RouteModel({
    required this.pathName,
    required this.fullPath,
  });
}
