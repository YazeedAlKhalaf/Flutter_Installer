import 'dart:async';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.dart';
import 'package:flutter_installer/src/app/services/router_service.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';

class StartupViewModel extends CustomBaseViewModel {
  final RouterService? _routerService = locator<RouterService>();

  Future<void> handleStartup() async {
    Timer(
      Duration(
        seconds: 2,
      ),
      () async {
        await navigateToHomeView();
      },
    );
  }

  Future<void> navigateToHomeView() async {
    await _routerService!.router.pushAndPopUntil(
      HomeRoute(),
      predicate: (_) => false,
    );
  }
}
