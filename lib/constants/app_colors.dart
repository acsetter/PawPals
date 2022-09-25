
import 'package:flutter/material.dart';

/// Colors the app will use throughout the entire UI. <br>
/// Color generator: http://mcg.mbitson.com/#!?ourprimary=%23816aba&themename=mcgtheme
class AppColors {
  AppColors._();

  // Primary Color:
  static const int _primaryValue = 0xFF816ABA;
  static const int _primaryAccentValue = 0xFFC3B2FF;

  static const MaterialColor primary = MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFF0EDF7),
    100: Color(0xFFD9D2EA),
    200: Color(0xFFC0B5DD),
    300: Color(0xFFA797CF),
    400: Color(0xFF9480C4),
    500: Color(_primaryValue),
    600: Color(0xFF7962B3),
    700: Color(0xFF6E57AB),
    800: Color(0xFF644DA3),
    900: Color(0xFF513C94),
  });

  static const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFEBE5FF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF9C7FFF),
    700: Color(0xFF8965FF),
  });

  // Error Color:
  static const int _errorValue = 0xFFD04545;
  static const int _errorAccentValue = 0xFFFFB8B8;

  static const MaterialColor error = MaterialColor(_errorValue, <int, Color>{
    50: Color(0xFFF9E9E9),
    100: Color(0xFFF1C7C7),
    200: Color(0xFFE8A2A2),
    300: Color(0xFFDE7D7D),
    400: Color(0xFFD76161),
    500: Color(_errorValue),
    600: Color(0xFFCB3E3E),
    700: Color(0xFFC43636),
    800: Color(0xFFBE2E2E),
    900: Color(0xFFB31F1F),
  });

  static const MaterialColor errorAccent = MaterialColor(_errorAccentValue, <int, Color>{
    100: Color(0xFFFFEBEB),
    200: Color(_errorAccentValue),
    400: Color(0xFFFF8585),
    700: Color(0xFFFF6C6C),
  });

  // TODO: Create secondary and tertiary colors for the app.
}