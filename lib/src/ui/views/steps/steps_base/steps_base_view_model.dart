import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/views/steps/customize/customize_view.dart';
import 'package:flutter_installer/src/ui/views/steps/customize/customize_view_model.dart';
import 'package:flutter_installer/src/ui/views/steps/done/done_view.dart';
import 'package:flutter_installer/src/ui/views/steps/installing/installing_view.dart';
import 'package:flutter_installer/src/ui/views/steps/summary/summary_view.dart';
import 'package:flutter_installer/src/ui/views/steps/terms_of_service/terms_of_service_view.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';
import 'package:stacked/stacked.dart';

class StepsBaseViewModel extends BaseViewModel {
  int _currentIndex;
  int get currentIndex => _currentIndex;

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
    final CustomizeViewModel customizeViewModel = CustomizeViewModel();
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
          onNextPressed: () {
            setCurrentIndex(2);
          },
        );
        break;
      case 2:
        return SummaryView(
          onInstallPressed: () {
            setCurrentIndex(3);
          },
          userChoice: UserChoice(
            installationPath: customizeViewModel.installationPath,
            installVisualStudioCode: customizeViewModel.installVisualStudioCode,
            installAndroidStudio: customizeViewModel.installAndroidStudio,
            installIntelliJIDEA: customizeViewModel.installIntelliJIDEA,
            installGit: customizeViewModel.installGit,
          ),
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
}
