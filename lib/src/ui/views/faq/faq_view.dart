import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

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
        final TextStyle verticalTextStyle = GoogleFonts.roboto(
          fontSize: blockSize(context) * 7,
          fontWeight: FontWeight.bold,
          color: textColorWhite,
        );

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
                      color: primaryColor,
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
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 2,
                            color: textColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          buttonColor: accentColor,
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
                      child: Column(
                        children: <Widget>[
                          // TODO(yazeed): Finish the FAQ view
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
