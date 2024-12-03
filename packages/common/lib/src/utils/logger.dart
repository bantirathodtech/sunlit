import 'package:flutter/foundation.dart';

class Logger {
  static const String _defaultTag = 'APP';

  static void log(String message,
      {String level = 'INFO', String tag = _defaultTag}) {
    if (kDebugMode) {
      print('[$level] [$tag] ${DateTime.now()}: $message');
    }
  }

  static void info(String message, {String tag = _defaultTag}) {
    log(message, level: 'INFO', tag: tag);
  }

  static void warning(String message, {String tag = _defaultTag}) {
    log(message, level: 'WARNING', tag: tag);
  }

  static void error(String message, {String tag = _defaultTag}) {
    log(message, level: 'ERROR', tag: tag);
  }

  static void debug(String message, {String tag = _defaultTag}) {
    log(message, level: 'DEBUG', tag: tag);
  }

  static void logFormatted(String tag, String message) {
    log(message, level: 'INFO', tag: tag);
  }

  static void logNetwork(String message,
      {String method = '', String url = ''}) {
    String networkMessage = message;
    if (method.isNotEmpty) networkMessage = '$method: $networkMessage';
    if (url.isNotEmpty) networkMessage = '$networkMessage\nURL: $url';
    log(networkMessage, level: 'NETWORK', tag: 'API');
  }

  static void logGraphQL(String operation, String query) {
    log('GraphQL $operation:\n$query', level: 'GRAPHQL', tag: 'API');
  }

  static void logPerformance(String action, int durationMs) {
    log('$action took $durationMs ms', level: 'PERFORMANCE', tag: 'PERF');
  }

  static void logState(String stateName, String stateValue) {
    log('$stateName: $stateValue', level: 'STATE', tag: 'STATE');
  }

  static void separatorLine({String tag = _defaultTag}) {
    if (kDebugMode) {
      print('[$tag] ${'-' * 50}');
    }
  }
}
