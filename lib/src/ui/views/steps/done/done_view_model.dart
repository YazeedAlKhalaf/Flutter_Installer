import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class DoneViewModel extends CustomBaseViewModel {
  final Utils? _utils = locator<Utils>();

  Future<String> getStringFromFile(String path) async {
    return await _utils!.getStringFromFile(path);
  }

  Future<void> initialize() async {
    _markdownData = await rootBundle.loadString('assets/misc/done.md');
    notifyListeners();
  }

  String get markdownData => _markdownData;
  String _markdownData = '';
}
