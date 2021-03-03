import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.text,
    @required this.width,
    @required this.onPressed,
    this.textStyle,
    this.buttonColor,
    this.isButtonDisabled = false,
  });

  final String text;
  final double width;
  final VoidCallback onPressed;

  final TextStyle textStyle;
  final Color buttonColor;

  final bool isButtonDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              500,
            ),
          ),
          primary: Colors.white,
          backgroundColor: buttonColor ?? Theme.of(context).accentColor,
          onSurface: Colors.grey,
        ),
        onPressed: isButtonDisabled ? null : onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: blockSize(context),
            vertical: blockSize(context) * 0.5,
          ),
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  color: textColorWhite,
                  fontSize: 20,
                ),
          ),
        ),
      ),
    );
  }
}
