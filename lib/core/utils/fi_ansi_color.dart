/// class from: https://github.com/leisim/logger/blob/master/lib/src/ansi_color.dart
///
/// This class handles colorizing of terminal output.
class FiAnsiColor {
  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  final int? fg;
  final bool color;

  FiAnsiColor.none()
      : fg = null,
        color = false;

  FiAnsiColor.fg(this.fg) : color = true;

  static FiAnsiColor red() => FiAnsiColor.fg(31);
  static FiAnsiColor green() => FiAnsiColor.fg(32);
  static FiAnsiColor yellow() => FiAnsiColor.fg(33);
  static FiAnsiColor blue() => FiAnsiColor.fg(34);
  static FiAnsiColor magenta() => FiAnsiColor.fg(35);
  static FiAnsiColor cyan() => FiAnsiColor.fg(36);
  static FiAnsiColor white() => FiAnsiColor.fg(37);
  static FiAnsiColor orange() => FiAnsiColor.fg(91);

  @override
  String toString() {
    if (fg != null) {
      return '$ansiEsc${fg}m';
    } else {
      return '';
    }
  }

  String call(String msg) {
    if (color) {
      // `this` in here calls the `toString` method.
      return '${this}$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => color ? '${ansiEsc}39m' : '';

  /// Defaults the terminal's background color without altering the foreground.
  String get resetBackground => color ? '${ansiEsc}49m' : '';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
}
