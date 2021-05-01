import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        model.initializeWindowSize();

        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Opacity(
                      opacity: 0.15,
                      child: Image.asset(
                        'assets/images/logo_flutter_1080px_clr.png',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(blockSize(context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ExpandedContainer(),
                          Image.asset(
                            'assets/images/flutter_installer_logo.png',
                            width: blockSize(context) * 15,
                          ),
                          verticalSpaceSmall(context),
                          Text(
                            'Flutter Installer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 3,
                            ),
                          ),
                          verticalSpaceSmall(context),
                          CustomButton(
                            onPressed: () async {
                              await model.navigateToStepsBaseView();
                            },
                            text: 'Get Started',
                            width: blockSize(context) * 30,
                            textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: textColorWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 3,
                            ),
                          ),
                          ExpandedContainer(),
                          Text(
                            'Made With Flutter 💙',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: blockSize(context) * 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              'Flutter and the related logo are trademarks of Google LLC.\nWe are not endorsed by or affiliated with Google LLC.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: blockSize(context) * 0.9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
