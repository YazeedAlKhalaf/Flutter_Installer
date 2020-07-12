import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class InstallingViewModel extends CustomBaseViewModel {
  final DialogService _dialogService = locator<DialogService>();

  double _percentage;
  double get percentage => _percentage;
  void setPercentage(double newValue) {
    _percentage = newValue;
    notifyListeners();
  }

  String _currentTaskText = '';
  String get currentTaskText => _currentTaskText;
  void setCurrentTaskText(String newValue) {
    _currentTaskText = newValue;
    notifyListeners();
  }

  initialize() {
    setPercentage(0.0);
  }

  Future<bool> showCancelConfirmationDialog() async {
    DialogResponse dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are You Sure? 😢',
      description: 'Are You Sure You Wanna Cancel This Download? 😢',
      cancelTitle: 'No, Thanks God 🙏',
      confirmationTitle: 'Yes, I\'m Pretty Sure 🚀',
      dialogPlatform: DialogPlatform.Material,
    );

    return dialogResponse.confirmed;
  }
}
