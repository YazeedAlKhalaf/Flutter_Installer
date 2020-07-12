import 'package:injectable/injectable.dart';

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
}
