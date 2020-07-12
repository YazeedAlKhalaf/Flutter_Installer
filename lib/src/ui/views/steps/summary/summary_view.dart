import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './summary_view_model.dart';

class SummaryView extends StatelessWidget {
  final Function() onInstallPressed;
  final UserChoice userChoice;

  const SummaryView({
    @required this.onInstallPressed,
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
                padding: EdgeInsets.all(blockSize(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Summary',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: textColorBlack,
                            fontSize: blockSize(context) * 5,
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
                                  style: GoogleFonts.robotoMono(
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
                                        style: GoogleFonts.robotoMono(
                                          color: lynchColor,
                                          fontSize: blockSize(context) * 1.2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (userChoice.installVisualStudioCode)
                                        Text(
                                          '• Visual Studio Code Latest Version',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.robotoMono(
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installAndroidStudio)
                                        Text(
                                          '• Android Studio Latest Version',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.robotoMono(
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installIntelliJIDEA)
                                        Text(
                                          '• IntelliJ IDEA Latest Version',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.robotoMono(
                                            color: lynchColor,
                                            fontSize: blockSize(context) * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (userChoice.installGit)
                                        Text(
                                          '• Git',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.robotoMono(
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CustomButton(
                          text: 'INSTALL',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 2.5,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          buttonColor: primaryColor,
                          width: blockSize(context) * 20,
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
