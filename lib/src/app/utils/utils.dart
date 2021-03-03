import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class Utils {
  String clipTextFromMiddle(
    String textToClip, {
    int clipThreshold = 45,
  }) {
    final int textToClipLength = textToClip.length;
    if (textToClipLength >= clipThreshold) {
      final String editedText = '''
${textToClip.substring(0, 20)}...${textToClip.substring(textToClipLength - 20, textToClipLength)}''';

      return editedText;
    }

    return textToClip;
  }

  Future<String> getStringFromFile(String path) async {
    return rootBundle.loadString(path);
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

  String getAnythingAfterLastSlash(String text) {
    final RegExp getAnythingAfterLastSlash = RegExp('[^/]+\$');
    final RegExpMatch matches = getAnythingAfterLastSlash.firstMatch(text);

    return matches[0];
  }

  String randomString(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final StringBuffer result = StringBuffer();
    final Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    for (int i = 0; i < length; i++) {
      result.write(chars[rnd.nextInt(chars.length)]);
    }
    return result.toString();
  }
}
