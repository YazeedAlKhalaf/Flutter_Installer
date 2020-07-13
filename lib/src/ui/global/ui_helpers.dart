import 'package:flutter/material.dart';

class _SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  // ignore: unused_field
  static double safeBlockHorizontal;
  // ignore: unused_field
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    blockSizeHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    blockSizeVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

double _blockSizeHorizontal(BuildContext context) {
  return _SizeConfig.blockSizeHorizontal;
}

double _blockSizeVertical(BuildContext context) {
  return _SizeConfig.blockSizeVertical;
}

double screenWidth(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.screenWidth;
}

double screenHeight(BuildContext context) {
  _SizeConfig().init(context);
  return _SizeConfig.screenHeight;
}

double blockSize(BuildContext context) {
  _SizeConfig().init(context);
  double blockSize =
      (_blockSizeVertical(context) + _blockSizeHorizontal(context) / 2);
  return blockSize;
}

Widget verticalSpaceSmall(BuildContext context) {
  return SizedBox(
    height: blockSize(context) * 2,
  );
}

Widget verticalSpaceMedium(BuildContext context) {
  return SizedBox(
    height: blockSize(context) * 5,
  );
}

Widget verticalSpaceLarge(BuildContext context) {
  return SizedBox(
    height: blockSize(context) * 10,
  );
}

Widget horizontalSpaceSmall(BuildContext context) {
  return SizedBox(
    width: blockSize(context) * 2,
  );
}

Widget horizontalSpaceMedium(BuildContext context) {
  return SizedBox(
    width: blockSize(context) * 5,
  );
}

Widget horizontalSpaceLarge(BuildContext context) {
  return SizedBox(
    width: blockSize(context) * 10,
  );
}
