import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/services/router_service.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:flutter_installer/src/ui/views/steps/customize/customize_view.dart';
import 'package:flutter_installer/src/ui/views/steps/done/done_view.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/installing_view.dart';
import 'package:flutter_installer/src/ui/views/steps/summary/summary_view.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';

class StepsBaseViewModel extends CustomBaseViewModel {
  final RouterService? _routerService = locator<RouterService>();

  bool _showFAQView = false;
  bool get showFAQView => _showFAQView;
  void setShowFAQView(bool newValue) {
    _showFAQView = newValue;
    notifyListeners();
  }

  UserChoice? _userChoice;
  UserChoice? get userChoice => _userChoice;

  int? _currentIndex;
  int? get currentIndex => _currentIndex;
  void setUserChoice(UserChoice newValue) {
    _userChoice = newValue;
    notifyListeners();
  }

  void setCurrentIndex(
    /// `newIndex` can't be more than `3`
    /// `3` is the maximum
    /// `0` is the minimum
    int newIndex,
  ) {
    assert(newIndex <= 3 && newIndex >= 0);
    _currentIndex = newIndex;
    notifyListeners();
  }

  void initialize() {
    setCurrentIndex(0);
  }

  StepWidgetState decideStepState(int stepIndex) {
    if (_currentIndex == stepIndex) {
      return StepWidgetState.Doing;
    }

    if (_currentIndex! > stepIndex) {
      return StepWidgetState.Done;
    }

    return StepWidgetState.NotDone;
  }

  decideStepView() {
    switch (_currentIndex) {
      case 0:
        return CustomizeView(
          userChoice: userChoice,
          onNextPressed: (UserChoice userChoice) {
            setCurrentIndex(1);
            setUserChoice(userChoice);
          },
        );
      case 1:
        return SummaryView(
          onBackPressed: () {
            setCurrentIndex(0);
          },
          onInstallPressed: () {
            setCurrentIndex(2);
          },
          userChoice: _userChoice,
        );
      case 2:
        return InstallingView(
          onNextPressed: () {
            setCurrentIndex(3);
          },
          onCancelPressed: () async {
            await navigateToHomeView();
          },
          userChoice: _userChoice,
        );
      case 3:
        return DoneView(
          onFinishPressed: () {},
        );
      default:
    }
  }

  Future<void> navigateToHomeView() async {
    await _routerService!.router.pushAndPopUntil(
      HomeRoute(),
      predicate: (_) => false,
    );
  }
}
