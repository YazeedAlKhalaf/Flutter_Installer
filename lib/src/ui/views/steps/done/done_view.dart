import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter_installer/src/ui/widgets/custom_button.dart';
import 'package:flutter_installer/src/ui/widgets/expanded_container.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './done_view_model.dart';

const String _markdownData = """
# Congrats 🎉

- Now you have Flutter SDK installed on your system 💙😎.
- Don't forget to run `flutter doctor -v` in your terminal.
- For More Info Visit: [Flutter Website](https://flutter.dev/)

  **For reporting any issues or asking questions, Visit Flutter Installer GitHub Repo: [Flutter Installer](https://github.com/YazeedAlKhalaf/Flutter_Installer/)**
""";

class DoneView extends StatelessWidget {
  final Function onFinishPressed;

  const DoneView({
    @required this.onFinishPressed,
  });

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
                padding: EdgeInsets.all(blockSize(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HOOORAY🚀💙😎',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: textColorBlack,
                        fontSize: blockSize(context) * 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ExpandedContainer(),
                    FutureBuilder<String>(
                      // future: model.getStringFromFile('assets/misc/done.md'),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<String> snapshot,
                      ) {
                        // if (!snapshot.hasData ||
                        //     snapshot.connectionState != ConnectionState.done) {
                        //   return ClipRRect(
                        //     borderRadius: BorderRadius.circular(
                        //       20,
                        //     ),
                        //     child: Container(
                        //       padding: EdgeInsets.all(
                        //         blockSize(context) * 2,
                        //       ),
                        //       width: blockSize(context) * 10,
                        //       decoration: BoxDecoration(
                        //         color: Colors.grey[300],
                        //       ),
                        //       child: Center(
                        //         child: CircularProgressIndicator(),
                        //       ),
                        //     ),
                        //   );
                        // }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            height: blockSize(context) * 30,
                            width: blockSize(context) * 50,
                            child: Markdown(
                              data: _markdownData,
                              styleSheet: MarkdownStyleSheet(
                                code: GoogleFonts.robotoMono(
                                  backgroundColor: Colors.grey[350],
                                  fontWeight: FontWeight.bold,
                                  fontSize: blockSize(context) * 1.5,
                                ),
                                h1: GoogleFonts.roboto(
                                  color: textColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: blockSize(context) * 3,
                                ),
                                p: GoogleFonts.roboto(
                                  color: textColorBlack,
                                  fontSize: blockSize(context) * 1.5,
                                ),
                              ),
                              onTapLink: (String link) {
                                model.launchUrl(link);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ExpandedContainer(),
                    CustomButton(
                      text: 'Finish!',
                      buttonColor: accentColor,
                      textStyle: GoogleFonts.roboto(
                        fontSize: blockSize(context) * 4.5,
                        fontWeight: FontWeight.bold,
                        color: textColorWhite,
                      ),
                      width: blockSize(context) * 40,
                      onPressed: () {
                        onFinishPressed();
                      },
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
