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
  const CustomizeView({
    this.userChoice,
    @required this.onNextPressed,
  });
  final UserChoice userChoice;
  final Function(UserChoice userChoice) onNextPressed;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomizeViewModel>.reactive(
      viewModelBuilder: () => CustomizeViewModel(),
      onModelReady: (CustomizeViewModel model) async {
        await model.intialize(
          userChoice: userChoice,
        );
      },
      builder: (
        BuildContext context,
        CustomizeViewModel model,
        Widget child,
      ) {
        Expanded _buildCheckBoxTile({
          @required String logoPath,
          @required String appName,
          @required bool value,
          @required void Function(bool) onChanged,
        }) {
          return Expanded(
            child: CheckboxListTile(
              activeColor: Theme.of(context).accentColor,
              title: Row(
                children: <Widget>[
                  Image.asset(
                    logoPath,
                    width: blockSize(context) * 3,
                  ),
                  horizontalSpaceSmall(context),
                  SizedBox(
                    child: Text(
                      appName,
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: blockSize(context) * 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              value: value,
              onChanged: onChanged,
            ),
          );
        }

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
                        SizedBox(
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
                                    : null,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: blockSize(context) * 1.5,
                              fontWeight: FontWeight.bold,
                              color: model.chooseFolderTextFieldHasError
                                  ? dangerColor
                                  : null,
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
                      color: Theme.of(context).primaryColor,
                      indent: 30,
                      endIndent: 30,
                    ),
                    verticalSpaceSmall(context),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: blockSize(context) * 2.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Choices
                          SizedBox(
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
                                    _buildCheckBoxTile(
                                      logoPath:
                                          'assets/images/app_logos/visual_studio_code_logo.png',
                                      appName: 'VS Code',
                                      value: model.installVisualStudioCode,
                                      onChanged:
                                          model.setInstallVisualStudioCode,
                                    ),
                                    _buildCheckBoxTile(
                                      logoPath:
                                          'assets/images/app_logos/android_studio_logo.png',
                                      appName: 'Android Studio',
                                      value: model.installAndroidStudio,
                                      onChanged: model.setInstallAndroidStudio,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    _buildCheckBoxTile(
                                      logoPath:
                                          'assets/images/app_logos/intellij_idea_logo.png',
                                      appName: 'IntelliJ IDEA',
                                      value: model.installIntelliJIDEA,
                                      onChanged: model.setInstallIntelliJIDEA,
                                    ),
                                    _buildCheckBoxTile(
                                      logoPath:
                                          'assets/images/app_logos/git_logo.png',
                                      appName: 'Git',
                                      value: model.installGit,
                                      onChanged: model.setInstallGit,
                                    ),
                                  ],
                                ),
                                verticalSpaceSmall(context),
                                if (model.showAdvanced)
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '''
Choose the Flutter channel you want to use:''',
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
                                            child:
                                                RadioListTile<FlutterChannel>(
                                              activeColor:
                                                  Theme.of(context).accentColor,
                                              title: Text(
                                                'Stable',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  fontSize:
                                                      blockSize(context) * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              value: FlutterChannel.stable,
                                              groupValue: model.flutterChannel,
                                              onChanged:
                                                  (FlutterChannel newValue) {
                                                model.setFlutterChannel(
                                                  newValue,
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child:
                                                RadioListTile<FlutterChannel>(
                                              activeColor:
                                                  Theme.of(context).accentColor,
                                              title: Text(
                                                'Beta',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  fontSize:
                                                      blockSize(context) * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              value: FlutterChannel.beta,
                                              groupValue: model.flutterChannel,
                                              onChanged:
                                                  (FlutterChannel newValue) {
                                                model.setFlutterChannel(
                                                  newValue,
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child:
                                                RadioListTile<FlutterChannel>(
                                              activeColor:
                                                  Theme.of(context).accentColor,
                                              title: Text(
                                                'Dev',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  fontSize:
                                                      blockSize(context) * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              value: FlutterChannel.dev,
                                              groupValue: model.flutterChannel,
                                              onChanged:
                                                  (FlutterChannel newValue) {
                                                model.setFlutterChannel(
                                                  newValue,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  Container(),
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
                    const ExpandedContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomButton(
                          text: 'Next',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: blockSize(context) * 2,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
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
                              );

                              return;
                            }
                            model.setChooseFolderTextFieldHasError(false);

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
