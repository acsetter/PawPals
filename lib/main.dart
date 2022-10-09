import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:paw_pals/utils/app_log.dart';
import 'package:paw_pals/firebase_options.dart';
import 'package:paw_pals/my_app.dart';

/// Main entry point into the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.log('Initialize Firebase service plugins...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Logger.log('Initialize MyApp()...');
  runApp(const MyApp());
}
