import 'package:flutter/foundation.dart';

class Logger {
  static void info(String message) {
    // ignore: avoid_print
    print('INFO: $message');
  }

  static void debug(String message) {
    if (kDebugMode) {
      print('DEBUG: $message');
    }
  }

  static void error(String message) {
    // ignore: avoid_print
    print('ERROR: $message');
  }
}
