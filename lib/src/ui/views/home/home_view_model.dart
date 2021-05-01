import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.dart';
import 'package:flutter_installer/src/app/services/router_service.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';

class HomeViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future<void> navigateToStepsBaseView() async {
    await _routerService.router.push(
      StepsBaseRoute(),
    );
  }
}
