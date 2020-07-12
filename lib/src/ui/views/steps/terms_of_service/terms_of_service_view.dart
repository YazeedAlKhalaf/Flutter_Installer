import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './terms_of_service_view_model.dart';

class TermsOfServiceView extends StatelessWidget {
  final Function onAgreePressed;

  const TermsOfServiceView({
    @required this.onAgreePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsOfServiceViewModel>.reactive(
      viewModelBuilder: () => TermsOfServiceViewModel(),
      builder: (
        BuildContext context,
        TermsOfServiceViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context)),
                child: Column(
                  children: [
                    Text(
                      'Terms of Service',
                      style: GoogleFonts.roboto(
                        color: textColorBlack,
                        fontSize: blockSize(context) * 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // TODO(yazeed): Add Terms of Service/EULA of Flutter SDK here
                    ExpandedContainer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          text: 'Disagree',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 3,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          buttonColor: dangerColor,
                          width: blockSize(context) * 20,
                          onPressed: () {
                            // TODO(yazeed): close installer if this button is pressed and save in memory that the user disagreed
                          },
                        ),
                        CustomButton(
                          text: 'Agree',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 3,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          buttonColor: accentColor,
                          width: blockSize(context) * 20,
                          onPressed: () {
                            // TODO(yazeed): Save the user's acceptance of the Terms of Service/EULA to the memory
                            onAgreePressed();
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
