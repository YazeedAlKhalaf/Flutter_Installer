import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/generated/router/router.gr.dart';
import 'package:flutter_installer/src/ui/global/custom_base_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class InstalledModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Logger logger = Logger();
  Future<void> checkFlutterInstallation() async {
    Platform.isWindows
        ? Process.run('where', <String>['flutter'])
            .then((ProcessResult result) async {
            if (result.exitCode == 0) {
              await _navigationService.pushNamedAndRemoveUntil(
                Routes.installed,
              );
              return logger.i('Flutter Already Installed');
            } else {
              await continueToHome();
            }
          })
        : Process.run('which', <String>['flutter'])
            .then((ProcessResult result) async {
            if (result.exitCode == 0) {
              await _navigationService.pushNamedAndRemoveUntil(
                Routes.installed,
              );
              return logger.i('Flutter Already Installed');
            } else {
              await continueToHome();
            }
          });
  }

  Future<void> continueToHome() async {
    await _navigationService.navigateTo(Routes.stepsBaseView);
  }
}
