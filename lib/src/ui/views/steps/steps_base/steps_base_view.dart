import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          stepName: 'Summary',
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
                        ExpandedContainer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  500,
                                ),
                              ),
                              icon: Icon(
                                Icons.help_outline,
                                color: textColorWhite,
                                size: blockSize(context) * 3.5,
                              ),
                              label: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: blockSize(context),
                                  vertical: blockSize(context) * 0.5,
                                ),
                                child: Text(
                                  'Get Help',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: textColorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: blockSize(context) * 2,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await model.navigateToFaqView();
                              },
                            ),
                          ],
                        ),
                        ExpandedContainer(),
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
