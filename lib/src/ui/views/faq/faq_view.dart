import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';

import 'package:stacked/stacked.dart';

import '../../global/ui_helpers.dart';
import './faq_view_model.dart';

class FaqView extends StatelessWidget {
  final Function() onBackPressed;

  const FaqView({
    @required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaqViewModel>.reactive(
      viewModelBuilder: () => FaqViewModel(),
      builder: (
        BuildContext context,
        FaqViewModel model,
        Widget child,
      ) {
        model.initializeWindowSize();
        final TextStyle verticalTextStyle = TextStyle(
          fontFamily: 'Roboto',
          fontSize: blockSize(context) * 7,
          fontWeight: FontWeight.bold,
          color: textColorWhite,
        );

        _buildQuestionAndAnswer({
          @required String question,
          @required String answer,
        }) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(blockSize(context) * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Q: $question',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: blockSize(context) * 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'A: $answer',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: blockSize(context) * 1.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Row(
                children: <Widget>[
                  // Left Side
                  Container(
                    width: blockSize(context) * 20,
                    padding: EdgeInsets.all(blockSize(context)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ExpandedContainer(),
                        Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                '🎈',
                                style: verticalTextStyle,
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                'FAQ ',
                                style: verticalTextStyle,
                              ),
                            ),
                          ],
                        ),
                        ExpandedContainer(),
                        CustomButton(
                          text: 'Back',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: blockSize(context) * 2,
                            color: textColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          width: blockSize(context) * 15,
                          onPressed: () async {
                            onBackPressed();
                          },
                        ),
                        ExpandedContainer(),
                      ],
                    ),
                  ),

                  // Right Side
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(
                        blockSize(context) * 2,
                      ),
                      child: ListView(
                        children: <Widget>[
                          _buildQuestionAndAnswer(
                            question: 'What is Flutter Installer?',
                            answer:
                                'Flutter Installer is a tool made by Yazeed AlKhalaf for installing Flutter and needed software to your machine or environment.',
                          ),
                          _buildQuestionAndAnswer(
                            question:
                                'Why use Flutter to build an installer for Flutter?',
                            answer:
                                'Flutter is great for a lot of things. This is a test to see how well it performs and is a great thing that a framework has the potential to build itself an installer :)',
                          ),
                          _buildQuestionAndAnswer(
                            question:
                                'Why does the app ask for my Sudo password? (mac only)',
                            answer:
                                'The app needs it to be able to add Flutter to your PATH and to copy Visual Studio Code to your applications folder.',
                          ),
                        ],
                      ),
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
