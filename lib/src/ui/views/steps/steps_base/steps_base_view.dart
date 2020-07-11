import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';
import 'package:stacked/stacked.dart';

import './steps_base_view_model.dart';

class StepsBaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StepsBaseViewModel>.reactive(
      viewModelBuilder: () => StepsBaseViewModel(),
      onModelReady: (StepsBaseViewModel model) => model.initialize(),
      builder: (
        BuildContext context,
        StepsBaseViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Row(
                children: <Widget>[
                  // Left Side
                  Container(
                    width: blockSize(context) * 35,
                    padding: EdgeInsets.all(blockSize(context)),
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        StepWidget(
                          stepName: 'Terms of Service',
                          stepState: model.decideStepState(0),
                        ),
                        StepWidget(
                          stepName: 'Customize',
                          stepState: model.decideStepState(1),
                        ),
                        StepWidget(
                          stepName: 'Pre-installation Summary',
                          stepState: model.decideStepState(2),
                        ),
                        StepWidget(
                          stepName: 'Installing',
                          stepState: model.decideStepState(3),
                        ),
                        StepWidget(
                          stepName: 'Done!',
                          stepState: model.decideStepState(4),
                        ),
                      ],
                    ),
                  ),

                  // Right Side
                  Expanded(
                    child: Container(
                      child: model.decideStepView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
