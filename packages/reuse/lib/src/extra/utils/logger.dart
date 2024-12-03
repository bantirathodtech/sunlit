import 'dart:developer' as developer;

class Logger {
  static const String _defaultTag = 'APP_LOG';

  static void debug(String message, {String? tag}) {
    _log(Level.debug, message, tag: tag);
  }

  static void info(String message, {String? tag}) {
    _log(Level.info, message, tag: tag);
  }

  static void warning(String message, {String? tag}) {
    _log(Level.warning, message, tag: tag);
  }

  static void error(String message,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void _log(Level level, String message,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    final logTag = tag ?? _defaultTag;
    final logMessage = '[${level.name}] $logTag: $message';

    if (error != null || stackTrace != null) {
      developer.log(logMessage, error: error, stackTrace: stackTrace);
    } else {
      developer.log(logMessage);
    }

    // You can extend this to write logs to a file or remote server
    // _writeLogToFileOrRemoteServer(logMessage);
  }

  static void _writeLogToFileOrRemoteServer(String message) {
    // Implement file or remote server logging here
  }
}

enum Level {
  debug('DEBUG'),
  info('INFO'),
  warning('WARNING'),
  error('ERROR');

  final String name;
  const Level(this.name);
}
