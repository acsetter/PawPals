// Modified from Source: https://github.com/zubairehman/flutter-boilerplate-project

import 'dart:async';
import 'dart:convert';

import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Provides the localized resources (language support) for the app.
/// For simplicity, language resources are stored and accessed locally in
/// "assets/lang/".
class AppLocalizations {
  // localization variables
  final Locale locale;
  late Map<String, String> localizedStrings;
  late Map<String, dynamic> langMap;

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  // constructor
  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // This is a helper method that will load local specific strings from file
  // present in lang folder
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    langMap = json.decode(jsonString);

    return true;
  }

  /// Called within a widget to retrieve a localized string.
  ///
  /// **Example:** <br>
  /// AppLocalizations.of(context).translate("foo.bar") will retrieve: <br>
  /// {"foo": {"bar": **"this"**}} *from: "assets/lang/en.json"*
  String translate(String key) {
    List<String> keys = key.split('.');
    String lastKey = keys.removeLast();
    Pick map = pick(langMap);
    for (String k in keys) {
      map = map.call(k);
    }

    return map.call(lastKey).asStringOrThrow();
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // ignore: non_constant_identifier_names
  final String TAG = "AppLocalizations";

  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    // TODO: Maybe add spanish 'es' support?
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}