import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

import './installing_view_model.dart';

class InstallingView extends StatelessWidget {
  final Function() onNextPressed;
  final Function() onCancelPressed;
  final UserChoice userChoice;

  const InstallingView({
    @required this.onNextPressed,
    @required this.onCancelPressed,
    @required this.userChoice,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InstallingViewModel>.reactive(
      viewModelBuilder: () => InstallingViewModel(),
      onModelReady: (InstallingViewModel model) async {
        return model.initialize(
          userChoice: userChoice,
        );
      },
      builder: (
        BuildContext context,
        InstallingViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context) * 2),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Installing',
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
                    verticalSpaceSmall(context),
                    Container(
                      padding: EdgeInsets.all(blockSize(context) * 2),
                      child: LinearPercentIndicator(
                        lineHeight: 35,
                        percent: model.percentage,
                        center: Text(
                          "${(model.percentage * 100).toInt()}%",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: blockSize(context) * 2,
                            color: model.percentage >= 0.5
                                ? textColorWhite
                                : textColorBlack,
                          ),
                        ),
                        progressColor: primaryColor,
                      ),
                    ),
                    Container(
                      child: Text(
                        model.currentTaskText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: blockSize(context) * 1.5,
                          color: lynchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ExpandedContainer(),
                    model.showLog
                        ? StreamBuilder<List<Line>>(
                            stream: model.linesCtlr.stream,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<List<Line>> snapshot,
                            ) {
                              if (snapshot.data == null) {
                                return Container();
                              }

                              List<Widget> getLines() {
                                return snapshot.data.map(
                                  (Line line) {
                                    return Text(
                                      line.text ?? '',
                                      style: line is ErrLine
                                          ? TextStyle(
                                              color: dangerColor,
                                              fontSize:
                                                  blockSize(context) * 1.3,
                                              fontWeight: FontWeight.bold,
                                            )
                                          : TextStyle(
                                              color: textColorWhite,
                                              fontSize:
                                                  blockSize(context) * 1.3,
                                            ),
                                    );
                                  },
                                ).toList();
                              }

                              return Card(
                                color: textColorBlack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                elevation: 15,
                                child: Container(
                                  height: blockSize(context) * 20,
                                  width: blockSize(context) * 50,
                                  margin: EdgeInsets.all(blockSize(context)),
                                  decoration: BoxDecoration(
                                    color: textColorBlack,
                                  ),
                                  child: ListView.builder(
                                    controller: model.scrollController,
                                    itemCount: getLines().length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      if (index != 0) {
                                        model.scrollController.animateTo(
                                          model.scrollController.position
                                              .maxScrollExtent,
                                          duration: Duration(
                                            milliseconds: 200,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      return getLines()[index];
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : ExpandedContainer(),
                    ExpandedContainer(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CustomButton(
                            text: 'Cancel',
                            textStyle: TextStyle(
                              fontFamily: 'Roboto',
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
                            isButtonDisabled:
                                model.percentage >= 1.0 ? true : false,
                          ),
                          !model.showLog
                              ? CustomButton(
                                  text: 'Show Log',
                                  textStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: blockSize(context) * 2,
                                    color: textColorWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  buttonColor: primaryColor,
                                  width: blockSize(context) * 15,
                                  onPressed: () {
                                    if (!model.showLog) {
                                      model.setShowLog(true);
                                    }
                                  },
                                  isButtonDisabled:
                                      model.percentage >= 1.0 ? true : false,
                                )
                              : Container(),
                          CustomButton(
                            text: 'Next',
                            textStyle: TextStyle(
                              fontFamily: 'Roboto',
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
