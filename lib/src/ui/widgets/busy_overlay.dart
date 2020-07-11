import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';
import 'package:flutter/material.dart';

class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final TextStyle titleTextStyle;
  final bool show;
  final double sizeOfIndicator;

  const BusyOverlay({
    this.child,
    this.title,
    this.show = false,
    this.sizeOfIndicator,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Stack(
        children: <Widget>[
          child ?? Container(),
          show
              ? AbsorbPointer(
                  absorbing: true,
                  child: Opacity(
                    opacity: 1.0,
                    child: Container(
                      width: screenWidth(context),
                      height: screenHeight(context),
                      alignment: Alignment.center,
                      color: Color.fromARGB(
                        200,
                        0,
                        0,
                        0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SpinKitWave(
                            itemBuilder: (_, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                ),
                              );
                            },
                            size: sizeOfIndicator ?? blockSize(context) * 5,
                          ),
                          SizedBox(
                            height: blockSize(context),
                          ),
                          Text(
                            title ?? 'Please Wait...',
                            textAlign: TextAlign.center,
                            style: titleTextStyle ??
                                TextStyle(
                                  fontSize: blockSize(context) * 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
