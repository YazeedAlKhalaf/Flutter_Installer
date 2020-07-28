import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';

import 'package:stacked/stacked.dart';

import './summary_view_model.dart';

class SummaryView extends StatelessWidget {
  final Function() onBackPressed;
  final Function() onInstallPressed;
  final UserChoice userChoice;

  const SummaryView({
    @required this.onInstallPressed,
    @required this.onBackPressed,
    @required this.userChoice,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SummaryViewModel>.reactive(
      viewModelBuilder: () => SummaryViewModel(),
      builder: (
        BuildContext context,
        SummaryViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context) * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Summary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: textColorBlack,
                            fontSize: blockSize(context) * 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ExpandedContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: blockSize(context) * 50,
                            padding: EdgeInsets.all(
                              blockSize(context) * 3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '* This is a summary of what will be downloaded:',
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    color: lynchColor,
                                    fontSize: blockSize(context) * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: blockSize(context),
                                    left: blockSize(context) * 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        userChoice.installationPath != null
                                            ? '• Path: ' +
                                                locator<Utils>()
                                                    .clipTextFromMiddle(
                                                  userChoice.installationPath,
                                                )
                                            : '• Path: Not Specified',
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          color: lynchColor,
                                          fontSize: blockSize(context) * 1.2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (userChoice.installVisualStudioCode)
                                        Text(
                                          '• Visual Studio Code Latest Version',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installAndroidStudio)
                                        Text(
                                          '• Android Studio Latest Version',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installIntelliJIDEA)
                                        Text(
                                          '• IntelliJ IDEA Latest Version',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installGit)
                                        Text(
                                          '• Git',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ExpandedContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomButton(
                          text: 'Back',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: blockSize(context) * 2,
                            color: textColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          buttonColor: primaryColor,
                          width: blockSize(context) * 15,
                          onPressed: () {
                            onBackPressed();
                          },
                        ),
                        CustomButton(
                          text: 'INSTALL',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: blockSize(context) * 2,
                            color: textColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          buttonColor: primaryColor,
                          width: blockSize(context) * 15,
                          onPressed: () {
                            onInstallPressed();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
