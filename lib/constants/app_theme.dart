
import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The theme of the app (colors, fonts, text, etc).
class AppTheme {
  const AppTheme._();

  static final ColorScheme _colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primary.shade50,
      onSecondary: AppColors.primary.shade900,
      error: AppColors.error,
      onError: Colors.white,
      background: Colors.white,
      onBackground: AppColors.primary.shade900,
      surface: Colors.white,
      onSurface: AppColors.primary.shade900
  );

  static ThemeData light() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: _colorScheme,
      //TODO: Research how to create proper material TextThemes.
      // textTheme: const TextTheme(
      //   headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      //   headline2: TextStyle(fontSize: 28.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      //   headline3: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      //   headline4: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
      //   headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //   bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
      // ),
    );
  }
}