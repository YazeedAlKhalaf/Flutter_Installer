import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_installer/src/app/models/user_choice.model.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_installer/src/ui/widgets/text_link.dart';

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
      onModelReady: (CustomizeViewModel model) async => await model.intialize(),
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
                                  20,
                                ),
                              ),
                              hintText: 'Please Choose Installation Location',
                              hintStyle: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: blockSize(context) * 1.5,
                                fontWeight: FontWeight.bold,
                                color: model.chooseFolderTextFieldHasError
                                    ? dangerColor
                                    : lynchColor,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: blockSize(context) * 1.5,
                              fontWeight: FontWeight.bold,
                              color: model.chooseFolderTextFieldHasError
                                  ? dangerColor
                                  : lynchColor,
                            ),
                            enabled: false,
                          ),
                        ),
                        CustomButton(
                          text: 'Browse',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
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
                          // Choices
                          Container(
                            height: blockSize(context) * 25,
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  'Choose apps you need:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontSize: blockSize(context) * 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CheckboxListTile(
                                        title: Text(
                                          'Install Visual Studio Code',
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
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
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
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
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
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
                                          style: TextStyle(
                                            fontFamily: 'RobotoMono',
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
                                verticalSpaceSmall(context),
                                model.showAdvanced
                                    ? Column(
                                        children: <Widget>[
                                          Text(
                                            'Choose the Flutter channel you want to use:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'RobotoMono',
                                              fontSize: blockSize(context) * 2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: RadioListTile<
                                                    FlutterChannel>(
                                                  title: Text(
                                                    'Stable Channel',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'RobotoMono',
                                                      fontSize:
                                                          blockSize(context) *
                                                              1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  value: FlutterChannel.stable,
                                                  groupValue:
                                                      model.flutterChannel,
                                                  onChanged: (FlutterChannel
                                                      newValue) {
                                                    model.setFlutterChannel(
                                                        newValue);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: RadioListTile<
                                                    FlutterChannel>(
                                                  title: Text(
                                                    'Beta Channel',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'RobotoMono',
                                                      fontSize:
                                                          blockSize(context) *
                                                              1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  value: FlutterChannel.beta,
                                                  groupValue:
                                                      model.flutterChannel,
                                                  onChanged: (FlutterChannel
                                                      newValue) {
                                                    model.setFlutterChannel(
                                                        newValue);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: RadioListTile<
                                                    FlutterChannel>(
                                                  title: Text(
                                                    'Dev Channel',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'RobotoMono',
                                                      fontSize:
                                                          blockSize(context) *
                                                              1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  value: FlutterChannel.dev,
                                                  groupValue:
                                                      model.flutterChannel,
                                                  onChanged: (FlutterChannel
                                                      newValue) {
                                                    model.setFlutterChannel(
                                                        newValue);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                TextLink(
                                  model.showAdvanced
                                      ? 'Hide Advanced'
                                      : 'Show Advanced',
                                  style: TextStyle(
                                    color: textColorLink,
                                    fontFamily: 'RobotoMono',
                                    fontSize: blockSize(context) * 1.5,
                                  ),
                                  onPressed: () {
                                    model.setShowAdvanced(!model.showAdvanced);
                                  },
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
                        Platform.isMacOS
                            ? Container(
                                width: blockSize(context) * 30,
                                child: TextField(
                                  controller: model.sudoPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    labelText: 'Sudo Password',
                                    labelStyle: TextStyle(
                                      fontFamily: 'RobotoMono',
                                      fontSize: blockSize(context) * 1.5,
                                      color: model.sudoPasswordTextFieldHasError
                                          ? dangerColor
                                          : primaryColor,
                                    ),
                                    hintText: 'Please Enter Your Sudo Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'RobotoMono',
                                      fontSize: blockSize(context) * 1.1,
                                      color: model.sudoPasswordTextFieldHasError
                                          ? dangerColor
                                          : lynchColor,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        model.obscureSudoPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        model.setobscureSudoPassword(
                                            !model.obscureSudoPassword);
                                      },
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontSize: blockSize(context) * 1.1,
                                    // fontWeight: FontWeight.bold,
                                    color: model.sudoPasswordTextFieldHasError
                                        ? dangerColor
                                        : lynchColor,
                                  ),
                                  onChanged: model.setSudoPassword,
                                  obscureText: model.obscureSudoPassword,
                                ),
                              )
                            : Container(),
                        CustomButton(
                          text: 'Next',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
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
                              model.setChooseFolderTextFieldHasError(true);

                              model.showSnackBar(
                                title: 'Error Occured',
                                message:
                                    'You have to choose an installation path!',
                                iconData: Icons.close,
                              );

                              return;
                            }
                            model.setChooseFolderTextFieldHasError(false);

                            if (Platform.isMacOS) {
                              if (model.sudoPasswordController.text == null ||
                                  model.sudoPassword == null ||
                                  model.sudoPasswordController.text.trim() ==
                                      '' ||
                                  model.installationPath.trim() == '') {
                                model.setSudoPasswordTextFieldHasError(true);

                                model.showSnackBar(
                                  title: 'Error Occured',
                                  message: 'You must put your Sudo password!',
                                  iconData: Icons.close,
                                );

                                return;
                              }
                            }
                            model.setSudoPasswordTextFieldHasError(false);

                            onNextPressed(
                              UserChoice(
                                installationPath: model.installationPath,
                                installVisualStudioCode:
                                    model.installVisualStudioCode,
                                installAndroidStudio:
                                    model.installAndroidStudio,
                                installIntelliJIDEA: model.installIntelliJIDEA,
                                installGit: model.installGit,
                                flutterChannel: model.flutterChannel,
                                sudoPassword:
                                    Platform.isMacOS ? model.sudoPassword : '',
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
