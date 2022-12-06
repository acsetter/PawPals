import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:paw_pals/services/auth_service.dart';

import 'package:paw_pals/utils/app_log.dart';
import 'package:paw_pals/firebase_options.dart';
import 'package:paw_pals/my_app.dart';

/// Main entry point into the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  Logger.log('Initialize Firebase service plugins...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _handleArgs();
  Logger.log('Initialize MyApp()...');
  runApp(const MyApp());
}

/// Any additional args attached at start:
/// ` flutter run --dart-define=<OPTION>="<VALUE>" `
void _handleArgs() {
  // --dart-define=EMAIL="<App-Login-Email>"
  String email = const String.fromEnvironment('EMAIL', defaultValue: '');
  // --dart-define=PASS="<App-Login-Password>"
  String pass = const String.fromEnvironment('PASS', defaultValue: '');

  if (email.isNotEmpty & pass.isNotEmpty) {
    AuthService.signIn(email: email, password: pass)
        .then((err) { if (err.isNotEmpty) throw Exception(err); }
    );
  }
}
