import 'dart:ui';

class AppInfo {
  AppInfo._();

  static String get appName => "Paw Pals";
  static String get defaultLanguage => "en";
  static String get defaultCountry => "US";

  static Locale get defaultLocale => Locale(defaultLanguage, defaultCountry);
  // Form validation constants
  static int get maxEmailLength => 320;
  static int get minPasswordLength => 8;
  static int get maxPasswordLength => 256;
  static int get maxUsernameLength => 32;
  static int get maxNameLength => 32;
  // Preference filter constants
  static int get maxPetAge => 50;
  static int get minPetAge => 0;
  static int get maxSearchRadius => 150;
  static int get minSearchRadius => 5;
}