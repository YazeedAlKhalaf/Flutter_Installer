import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';

class DoneViewModel extends CustomBaseViewModel {
  final Utils _utils = locator<Utils>();

  Future<String> getStringFromFile(String path) async {
    return await _utils.getStringFromFile(path);
  }

  String get markdownData => _markdownData;
  String _markdownData = """
# Congrats 🎉

- Now you have Flutter SDK installed on your system 💙😎.
- Don't forget to run `flutter doctor -v` in your terminal.
- For More Info Visit: [Flutter Website](https://flutter.dev/)

  **For reporting any issues or asking questions, Visit Flutter Installer GitHub Repo: [Flutter Installer](https://github.com/YazeedAlKhalaf/Flutter_Installer/)**
""";
}
