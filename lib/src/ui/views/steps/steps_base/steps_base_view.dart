import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';
import 'package:flutter_installer/src/ui/widgets/toggle.dart';

import 'package:stacked/stacked.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

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
        LiteRollingSwitch _buildChangeThemeButtons() {
          return LiteRollingSwitch(
            onChanged: (bool state) {
              if (ThemeModeHandler.of(context).themeMode != ThemeMode.light) {
                ThemeModeHandler.of(context).saveThemeMode(
                  ThemeMode.light,
                );
              } else {
                ThemeModeHandler.of(context).saveThemeMode(
                  ThemeMode.dark,
                );
              }
            },
          );
        }


        Column _buildStepsWidgets() {
          return Column(
            children: <Widget>[
              StepWidget(
                stepName: 'Customize',
                stepState: model.decideStepState(0),
              ),
              StepWidget(
                stepName: 'Summary',
                stepState: model.decideStepState(1),
              ),
              StepWidget(
                stepName: 'Installing',
                stepState: model.decideStepState(2),
              ),
              StepWidget(
                stepName: 'Done!',
                stepState: model.decideStepState(3),
              ),
            ],
          );
        }

        Row _buildGetHelpButton() {
          return Row(
            children: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      500,
                    ),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
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
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: blockSize(context) * 2,
                    ),
                  ),
                ),
                onPressed: () async {
                  model.setShowFAQView(true);
                },
              ),
            ],
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  child: Row(
                    children: <Widget>[
                      /// Left Side
                      Container(
                        width: blockSize(context) * 30,
                        padding: EdgeInsets.all(blockSize(context)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            _buildChangeThemeButtons(),
                            _buildStepsWidgets(),
                            const ExpandedContainer(),
                            _buildGetHelpButton(),
                            const ExpandedContainer(),
                          ],
                        ),
                      ),

                      /// Right Side
                      Expanded(
                        child: SizedBox(
                          child: Stack(
                            children: <Widget>[
                              model.decideStepView() as Widget,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.showFAQView) FaqView(
                        onBackPressed: () {
                          model.setShowFAQView(false);
                        },
                      ) else const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
