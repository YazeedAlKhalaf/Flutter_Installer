import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';

class DoneViewModel extends CustomBaseViewModel {
  final Utils _utils = locator<Utils>();

  Future<String> getStringFromFile(String path) async {
    return await _utils.getStringFromFile(path);
  }

  Future<void> launchUrl(String url) async {
    await _utils.launchUrl(url);
  }
}
