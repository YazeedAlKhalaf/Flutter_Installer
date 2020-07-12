import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './customize_view_model.dart';

class CustomizeView extends StatelessWidget {
  final Function(UserChoice userChoice) onNextPressed;

  const CustomizeView({
    @required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomizeViewModel>.reactive(
      viewModelBuilder: () => CustomizeViewModel(),
      builder: (
        BuildContext context,
        CustomizeViewModel model,
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
                          'Customize',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: blockSize(context) * 35,
                          child: TextField(
                            controller: model.chooseFolderController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  500,
                                ),
                              ),
                              hintText: 'Please Choose Installation Location',
                              hintStyle: GoogleFonts.robotoMono(
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            enabled: false,
                          ),
                        ),
                        CustomButton(
                          text: 'Browse',
                          width: blockSize(context) * 15,
                          onPressed: () async {
                            await model.onBrowsePressed();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: blockSize(context) * 1.5),
                    Divider(
                      thickness: 2,
                      color: lynchColor,
                      indent: 30,
                      endIndent: 30,
                    ),
                    SizedBox(height: blockSize(context) * 1.5),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: blockSize(context) * 2.5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose apps you need:',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoMono(
                              fontSize: blockSize(context) * 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Choices
                          CheckboxListTile(
                            title: Text(
                              'Install Visual Studio Code',
                              style: GoogleFonts.robotoMono(
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: model.installVisualStudioCode,
                            onChanged: model.setInstallVisualStudioCode,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Install Android Studio',
                              style: GoogleFonts.robotoMono(
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: model.installAndroidStudio,
                            onChanged: model.setInstallAndroidStudio,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Install IntelliJ IDEA',
                              style: GoogleFonts.robotoMono(
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: model.installIntelliJIDEA,
                            onChanged: model.setInstallIntelliJIDEA,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Install Git',
                              style: GoogleFonts.robotoMono(
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: model.installGit,
                            onChanged: model.setInstallGit,
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Container(),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Pro Tip: If you have any of them downloaded, uncheck it! 😎',
                          softWrap: true,
                          style: GoogleFonts.robotoMono(
                            fontSize: blockSize(context) * 1.25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomButton(
                          text: 'Next',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 2,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          buttonColor: accentColor,
                          width: blockSize(context) * 10,
                          onPressed: () {
                            onNextPressed(
                              UserChoice(
                                installationPath: model.installationPath,
                                installVisualStudioCode:
                                    model.installVisualStudioCode,
                                installAndroidStudio:
                                    model.installAndroidStudio,
                                installIntelliJIDEA: model.installIntelliJIDEA,
                                installGit: model.installGit,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // Expanded(
                    //   child: Container(),
                    // ),
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
