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
  SimpleLogPrinter(
    this.className,
  );
  final String className;

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  @override
  List<String> log(LogEvent event) {
    final Logger logger = Logger();
    final String logFilePath = _localStorageService.appDocPath;
    final String logFileName = '''
flutter_installer_log_${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}.txt''';

    final AnsiColor color = PrettyPrinter.levelColors[event.level];
    final String emoji = PrettyPrinter.levelEmojis[event.level];
    final String message = '$emoji $className - ${event.message}';

    File(
      '$logFilePath\\$logFileName',
    ).writeAsString(
      '[${DateTime.now()}] - $message \n',
      mode: FileMode.append,
      flush: true,
    );

    logger.i(color(message));

    return <String>[];
  }
}
