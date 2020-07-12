import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/views/steps/customize/customize_view.dart';
import 'package:flutter_installer/src/ui/views/steps/customize/customize_view_model.dart';
import 'package:flutter_installer/src/ui/views/steps/done/done_view.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/installing_view.dart';
import 'package:flutter_installer/src/ui/views/steps/summary/summary_view.dart';
import 'package:flutter_installer/src/ui/views/steps/terms_of_service/terms_of_service_view.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StepsBaseViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  UserChoice _userChoice;
  UserChoice get userChoice => _userChoice;

  int _currentIndex;
  int get currentIndex => _currentIndex;
  void setUserChoice(UserChoice newValue) {
    _userChoice = newValue;
    notifyListeners();
  }

  void setCurrentIndex(
    /// `newIndex` can't be more than `4`
    /// `4` is the maximum
    /// `0` is the minimum
    int newIndex,
  ) {
    assert(newIndex <= 4 && newIndex >= 0);
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

    if (_currentIndex > stepIndex) {
      return StepWidgetState.Done;
    }

    return StepWidgetState.NotDone;
  }

  decideStepView() {
    switch (_currentIndex) {
      case 0:
        return TermsOfServiceView(
          onAgreePressed: () {
            setCurrentIndex(1);
          },
        );
        break;
      case 1:
        return CustomizeView(
          onNextPressed: (UserChoice userChoice) {
            setCurrentIndex(2);
            setUserChoice(userChoice);
          },
        );
        break;
      case 2:
        return SummaryView(
          onInstallPressed: () {
            setCurrentIndex(3);
          },
          userChoice: _userChoice,
        );
        break;
      case 3:
        return InstallingView();
        break;
      case 4:
        return DoneView();
        break;
      default:
    }
  }

  Future<void> navigateToFaqView() async {
    await _navigationService.navigateTo(Routes.faqView);
  }
}
