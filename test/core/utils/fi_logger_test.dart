import 'package:flutter_installer/core/utils/fi_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "FiLogger |",
    () {
      test(
        "should return a Logger instance "
        "when FiLogger.getLogger is called "
        "with a loggerName.",
        () {
          final Logger logger = FiLogger.getLogger("loggerName");

          expect(logger, isA<Logger>());
        },
      );

      test(
        "should verify the Logger instance "
        "returned by FiLogger.getLogger "
        "with a loggerName is the same.",
        () {
          final Logger logger = FiLogger.getLogger("loggerName");

          expect(logger.name, "loggerName");
        },
      );
    },
  );
}
