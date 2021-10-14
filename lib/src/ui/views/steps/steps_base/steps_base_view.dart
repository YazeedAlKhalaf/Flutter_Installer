import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_installer/src/ui/widgets/step_widget.dart';

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
        Widget? child,
      ) {
        _buildChangeThemeButtons() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.sun,
                  color: textColorWhite,
                ),
                onPressed: () {
                  if (ThemeModeBuilderConfig.isDarkTheme()) {
                    ThemeModeBuilderConfig.setLight();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.moon,
                  color: textColorWhite,
                ),
                onPressed: () {
                  if (!ThemeModeBuilderConfig.isDarkTheme()) {
                    ThemeModeBuilderConfig.setDark();
                  }
                },
              ),
            ],
          );
        }

        _buildStepsWidgets() {
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

        _buildGetHelpButton() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      500,
                    ),
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
                Container(
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
                            ExpandedContainer(),
                            _buildGetHelpButton(),
                            ExpandedContainer(),
                          ],
                        ),
                      ),

                      /// Right Side
                      Expanded(
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              model.decideStepView(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                model.showFAQView
                    ? FaqView(
                        onBackPressed: () {
                          model.setShowFAQView(false);
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
