import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

import './installing_view_model.dart';

class InstallingView extends StatelessWidget {
  final Function() onNextPressed;
  final Function() onCancelPressed;

  const InstallingView({
    @required this.onNextPressed,
    @required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InstallingViewModel>.reactive(
      viewModelBuilder: () => InstallingViewModel(),
      onModelReady: (InstallingViewModel model) => model.initialize(),
      builder: (
        BuildContext context,
        InstallingViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context)),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Installing',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: textColorBlack,
                            fontSize: blockSize(context) * 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceSmall(context),
                    Container(
                      padding: EdgeInsets.all(blockSize(context) * 2),
                      child: LinearPercentIndicator(
                        lineHeight: 35,
                        percent: model.percentage,
                        center: Text(
                          "${(model.percentage * 100).toInt()}%",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: blockSize(context) * 2,
                            color: model.percentage >= 0.5
                                ? textColorWhite
                                : textColorBlack,
                          ),
                        ),
                        progressColor: accentColor,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Downloading Flutter',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(
                          fontSize: blockSize(context) * 1.5,
                          color: lynchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CustomButton(
                            text: 'Cancel',
                            textStyle: GoogleFonts.roboto(
                              fontSize: blockSize(context) * 2,
                              color: textColorWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            buttonColor: dangerColor,
                            width: blockSize(context) * 15,
                            onPressed: () async {
                              bool isSure =
                                  await model.showCancelConfirmationDialog();
                              if (isSure) {
                                onCancelPressed();
                              }
                            },
                          ),
                          CustomButton(
                            text: 'Next',
                            textStyle: GoogleFonts.roboto(
                              fontSize: blockSize(context) * 2,
                              color: textColorWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            buttonColor: primaryColor,
                            width: blockSize(context) * 15,
                            onPressed: () {
                              onNextPressed();
                            },
                            isButtonDisabled:
                                model.percentage >= 1.0 ? false : true,
                          ),
                        ],
                      ),
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
