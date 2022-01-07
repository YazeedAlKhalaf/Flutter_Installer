import 'dart:developer' as dev;

import 'package:flutter_installer/core/utils/fi_ansi_color.dart';
import 'package:logging/logging.dart';

export 'package:logging/logging.dart';

class FiLogger {
  static Logger getLogger(String loggerName) {
    return Logger(loggerName);
  }

  static final Map<Level, FiAnsiColor> _levelColors = <Level, FiAnsiColor>{
    Level.FINEST: FiAnsiColor.green(),
    Level.FINER: FiAnsiColor.cyan(),
    Level.FINE: FiAnsiColor.blue(),
    Level.CONFIG: FiAnsiColor.orange(),
    Level.INFO: FiAnsiColor.white(),
    Level.WARNING: FiAnsiColor.yellow(),
    Level.SEVERE: FiAnsiColor.red(),
    Level.SHOUT: FiAnsiColor.magenta(),
  };
  static final Map<Level, String> _levelEmojis = <Level, String>{
    Level.FINEST: "🪡",
    Level.FINER: "🧪",
    Level.FINE: "🔋",
    Level.CONFIG: "⚙️",
    Level.INFO: "💡",
    Level.WARNING: "⚠️",
    Level.SEVERE: "⛔️",
    Level.SHOUT: "👾",
  };

  static void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord logRecord) {
      final FiAnsiColor? color = _levelColors[logRecord.level];
      final String? emoji = _levelEmojis[logRecord.level];
      final String message = "${logRecord.time} - ${logRecord.message}";

      dev.log(
        color != null ? color(message) : message,
        time: logRecord.time,
        level: logRecord.level.value,
        name: "$emoji ${logRecord.loggerName}",
        error: logRecord.error,
        stackTrace: logRecord.stackTrace,
      );
    });
  }
}
