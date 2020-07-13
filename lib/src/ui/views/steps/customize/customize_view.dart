import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
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
                padding: EdgeInsets.all(blockSize(context) * 2),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Customize',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: textColorBlack,
                            fontSize: blockSize(context) * 4,
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
                                color: model.textFieldHasError
                                    ? dangerColor
                                    : lynchColor,
                              ),
                            ),
                            enabled: false,
                          ),
                        ),
                        CustomButton(
                          text: 'Browse',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 2,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          width: blockSize(context) * 15,
                          onPressed: () async {
                            await model.onBrowsePressed();
                          },
                        ),
                      ],
                    ),
                    verticalSpaceSmall(context),
                    Divider(
                      thickness: 2,
                      color: lynchColor,
                      indent: 30,
                      endIndent: 30,
                    ),
                    verticalSpaceSmall(context),
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
                          verticalSpaceSmall(context),
                          // Choices
                          Container(
                            height: blockSize(context) * 20,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CheckboxListTile(
                                        title: Text(
                                          'Install Visual Studio Code',
                                          style: GoogleFonts.robotoMono(
                                            fontSize: blockSize(context) * 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: model.installVisualStudioCode,
                                        onChanged:
                                            model.setInstallVisualStudioCode,
                                      ),
                                    ),
                                    Expanded(
                                      child: CheckboxListTile(
                                        title: Text(
                                          'Install Android Studio',
                                          style: GoogleFonts.robotoMono(
                                            fontSize: blockSize(context) * 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: model.installAndroidStudio,
                                        onChanged:
                                            model.setInstallAndroidStudio,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CheckboxListTile(
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
                                    ),
                                    Expanded(
                                      child: CheckboxListTile(
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpandedContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomButton(
                          text: 'Next',
                          textStyle: GoogleFonts.roboto(
                            fontSize: blockSize(context) * 2,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          buttonColor: primaryColor,
                          width: blockSize(context) * 15,
                          onPressed: () {
                            if (model.chooseFolderController.text == null ||
                                model.installationPath == null ||
                                model.chooseFolderController.text.trim() ==
                                    '' ||
                                model.installationPath.trim() == '') {
                              model.setTextFieldHasError(true);
                              model.showSnackBar(
                                title: 'Error Occured',
                                message:
                                    'You have to choose an installation path!',
                                iconData: Icons.close,
                              );

                              return;
                            }
                            model.setTextFieldHasError(false);
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
                    // ExpandedContainer(),
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
