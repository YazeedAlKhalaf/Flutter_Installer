import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/views/installed/installed_model.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

class Installed extends StatefulWidget {
  @override
  _InstalledState createState() => _InstalledState();
}

class _InstalledState extends State<Installed> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InstalledModel>.reactive(
        viewModelBuilder: () => InstalledModel(),
        builder: (
          BuildContext context,
          InstalledModel model,
          Widget child,
        ) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Lottie.asset('assets/misc/congrats.json',
                      width: blockSize(context) * 20),
                  Text(
                    'Yoho, you have already installed Flutter',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: blockSize(context) * 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton(
                        text: 'Close',
                        textStyle: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: blockSize(context) * 2,
                          color: textColorWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        buttonColor: dangerColor,
                        width: blockSize(context) * 15,
                        onPressed: () {
                          return exit(0);
                        },
                      ),
                      CustomButton(
                        onPressed: () async {
                          await model.continueToHome();
                        },
                        text: 'Continue',
                        textStyle: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: blockSize(context) * 2,
                          color: textColorWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        width: blockSize(context) * 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
