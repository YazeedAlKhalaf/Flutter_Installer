import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class Utils {
  String clipTextFromMiddle(
    String textToClip, {
    int clipThreshold = 45,
  }) {
    int textToClipLength = textToClip.length;
    if (textToClipLength >= clipThreshold) {
      String editedText = textToClip.substring(0, 20) +
          '...' +
          textToClip.substring(textToClipLength - 20, textToClipLength);

      return editedText;
    }

    return textToClip;
  }

  Future<String> getStringFromFile(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<void> launchUrl(String url) async {
    if (!Platform.isWindows) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      await launch(url);
    }
  }
}
