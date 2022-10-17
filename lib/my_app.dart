import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/constants/app_theme.dart';
import 'package:paw_pals/screens/home_screen.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/wrappers/auth_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/navbar.dart';

/// Root of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      // home: const AuthWrapper(
      //     home: HomeScreen(),
      //     login: LoginScreen()),
      home: const AuthWrapper(home: HomeScreen(), login: LoginScreen()),
      locale: const Locale("en", "US"),
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
                builder: (context) => Navbar(child: child)
            )
          ],
        );
      },
      localizationsDelegates: const [
        AppLocalizations.delegate
      ],
      theme: AppTheme.light()
    );
  }
}

