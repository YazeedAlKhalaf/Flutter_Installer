import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  final TextStyle textStyle;
  final Color buttonColor;

  CustomButton({
    @required this.text,
    @required this.width,
    @required this.onPressed,
    this.textStyle,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
        color: buttonColor ?? primaryColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                color: textColorWhite,
                fontSize: 40,
              ),
        ),
      ),
    );
  }
}
