// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import '../../lib_permissions/services/permissions_service.dart';

class SplashService {
  SplashService(this.permissionsService);

  final PermissionsService permissionsService;
  bool _appInitialized = false;

  Future<void> initializeApp() async {
    await permissionsService.load();
    _appInitialized = true;
  }

  bool get isAppInitialized => _appInitialized;
}
