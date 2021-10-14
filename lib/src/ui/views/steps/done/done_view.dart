import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stacked/stacked.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';

import './done_view_model.dart';

class DoneView extends StatelessWidget {
  final Function onFinishPressed;

  const DoneView({
    required this.onFinishPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoneViewModel>.reactive(
      viewModelBuilder: () => DoneViewModel(),
      onModelReady: (DoneViewModel model) async {
        await model.initialize();
      },
      builder: (
        BuildContext context,
        DoneViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context) * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HOOORAY🚀💙😎',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: blockSize(context) * 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ExpandedContainer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ThemeModeBuilderConfig.isDarkTheme()
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                        ),
                        height: blockSize(context) * 30,
                        width: blockSize(context) * 50,
                        child: Markdown(
                          data: model.markdownData,
                          styleSheet: MarkdownStyleSheet(
                            code: TextStyle(
                              fontFamily: 'RobotoMono',
                              backgroundColor:
                                  ThemeModeBuilderConfig.isDarkTheme()
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Colors.grey[350],
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 1.5,
                            ),
                            h1: TextStyle(
                              fontFamily: 'Roboto',
                              color: ThemeModeBuilderConfig.isDarkTheme()
                                  ? textColorWhite
                                  : textColorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 3,
                            ),
                            p: TextStyle(
                              fontFamily: 'Roboto',
                              color: ThemeModeBuilderConfig.isDarkTheme()
                                  ? textColorWhite
                                  : textColorBlack,
                              fontSize: blockSize(context) * 1.5,
                            ),
                          ),
                          onTapLink: (String new1, String? link, String new2) {
                            print(new1);
                            print(new2);
                            model.launchUrl(link);
                          },
                        ),
                      ),
                    ),
                    ExpandedContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomButton(
                          text: 'Finish!',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: blockSize(context) * 4.5,
                            fontWeight: FontWeight.bold,
                            color: textColorWhite,
                          ),
                          width: blockSize(context) * 40,
                          onPressed: () {
                            onFinishPressed();
                            exit(0);
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
