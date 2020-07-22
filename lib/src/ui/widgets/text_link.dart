import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;

  const TextLink(
    this.text, {
    this.onPressed,
    this.style,
    this.textAlign,
    this.overflow,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
        style: style,
        strutStyle: strutStyle,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
      ),
    );
  }
}
