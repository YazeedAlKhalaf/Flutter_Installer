import 'dart:io';

import 'package:flutter_installer/src/app/generated/locator/locator.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(
    printer: SimpleLogPrinter(
      className,
    ),
  );
}

class SimpleLogPrinter extends LogPrinter {
  final String className;

  SimpleLogPrinter(
    this.className,
  );

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  @override
  List<String> log(LogEvent event) {
    final String logFilePath = '${_localStorageService.appDocPath}';
    final String logFileName =
        'flutter_installer_log_${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}.txt';

    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    var message = '$emoji $className - ${event.message}';

    File(
      '$logFilePath\\$logFileName',
    ).writeAsString(
      '[${DateTime.now()}] - $message \n',
      mode: FileMode.append,
      flush: true,
    );

    print(color(message));

    return [];
  }
}
