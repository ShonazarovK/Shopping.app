import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void info(dynamic message, {dynamic error, StackTrace? stackTrace, dynamic extras}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
    _logExtras(extras);
  }

  static void warning(dynamic message, {dynamic error, StackTrace? stackTrace, dynamic extras}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
    _logExtras(extras);
  }

  static void error(dynamic message, {dynamic error, StackTrace? stackTrace, dynamic extras}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    _logExtras(extras);
  }

  static void debug(dynamic message, {dynamic error, StackTrace? stackTrace, dynamic extras}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
    _logExtras(extras);
  }

  static void _logExtras(dynamic extras) {
    if (extras != null) {
      if (extras is Map) {
        extras.forEach((key, value) {
          _logger.d('$key: $value');
        });
      } else {
        _logger.d('Extras: $extras');
      }
    }
  }
}