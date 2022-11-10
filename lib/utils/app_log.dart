import 'dart:developer' as developer;

import 'package:paw_pals/constants/app_config.dart';

///VoidCallback from logs
typedef LogWriterCallback = void Function(String text, {bool isError});

class Logger {
  const Logger._();

  static void log(String value, {bool isError = false}) {
    if (isError || AppConfig.isAppLogEnabled) developer.log(value, name: 'APP');
  }

  static void noUserError() {
    Logger.log("No User is logged into Firebase Auth.", isError: true);
  }
}

