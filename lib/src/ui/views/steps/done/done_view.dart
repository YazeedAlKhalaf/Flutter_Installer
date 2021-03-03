import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:stacked/stacked.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import './done_view_model.dart';

class DoneView extends StatelessWidget {
  const DoneView({
    @required this.onFinishPressed,
  });

  final Function onFinishPressed;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoneViewModel>.reactive(
      viewModelBuilder: () => DoneViewModel(),
      builder: (
        BuildContext context,
        DoneViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(blockSize(context) * 2),
                child: Column(
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
                    const ExpandedContainer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ThemeModeHandler.of(context).themeMode ==
                                  ThemeMode.system
                              ? Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[200]
                              : ThemeModeHandler.of(context).themeMode ==
                                      ThemeMode.dark
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
                              backgroundColor: ThemeModeHandler.of(context)
                                          .themeMode ==
                                      ThemeMode.system
                                  ? Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Colors.grey[350]
                                  : ThemeModeHandler.of(context).themeMode ==
                                          ThemeMode.dark
                                      ? Theme.of(context)
                                          .scaffoldBackgroundColor
                                      : Colors.grey[350],
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 1.5,
                            ),
                            h1: TextStyle(
                              fontFamily: 'Roboto',
                              color: ThemeModeHandler.of(context).themeMode ==
                                      ThemeMode.system
                                  ? Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? textColorWhite
                                      : textColorBlack
                                  : ThemeModeHandler.of(context).themeMode ==
                                          ThemeMode.dark
                                      ? textColorWhite
                                      : textColorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: blockSize(context) * 3,
                            ),
                            p: TextStyle(
                              fontFamily: 'Roboto',
                              color: ThemeModeHandler.of(context).themeMode ==
                                      ThemeMode.system
                                  ? Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? textColorWhite
                                      : textColorBlack
                                  : ThemeModeHandler.of(context).themeMode ==
                                          ThemeMode.dark
                                      ? textColorWhite
                                      : textColorBlack,
                              fontSize: blockSize(context) * 1.5,
                            ),
                          ),
                          onTapLink: (String text, String link, String title) {
                            assert(link != null);
                            model.launchUrl(link);
                          },
                        ),
                      ),
                    ),
                    const ExpandedContainer(),
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
                            return exit(0);
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
