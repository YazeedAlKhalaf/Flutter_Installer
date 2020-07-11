import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class FaqViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> navigateToHomeView() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}
