import 'package:flutter/material.dart';

import 'package:paw_pals/constants/reg_expressions.dart';
import 'package:paw_pals/utils/app_localizations.dart';

/// Form validation functions
mixin FormValidation<T extends StatefulWidget> on State<T> {
  String translate(String key) => AppLocalizations.of(context).translate(key);

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
     return translate("errors.empty-email");
    }
    if (!RegExpressions.email.hasMatch(value)) {
      return translate("errors.invalid-email");
    }

    return null;
  }

  /// Validate password for login.
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return translate("errors.empty-password");
    }

    return null;
  }

  /// Validate password for signup.
  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return translate("errors.empty-password");
    }
    if (!RegExpressions.eightChars.hasMatch(value)) {
      return translate("errors.weak-password");
    }
    if (!RegExpressions.oneUpperChar.hasMatch(value)) {
      return translate("errors.no-upper-char-password");
    }
    if (!RegExpressions.oneLowerChar.hasMatch(value)) {
      return translate("errors.no-lower-char-password");
    }
    if(!RegExpressions.oneDigit.hasMatch(value)) {
      return translate("errors.no-number-char-password");
    }
    if (!RegExpressions.oneSpecialChar.hasMatch(value)) {
      return translate("errors.no-special-char-password");
    }

    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return translate("errors.empty-username");
    }
    if (!RegExpressions.username.hasMatch(value)) {
      return translate("errors.invalid-username");
    }

    return null;
  }

  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return translate("errors.empty-first-name");
    }
    if (!RegExpressions.alpha.hasMatch(value)) {
      return translate("errors.invalid-name");
    }

    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return translate("errors.empty-last-name");
    }
    if (!RegExpressions.alpha.hasMatch(value)) {
      return translate("errors.invalid-name");
    }

    return null;
  }


  String? petNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ("No pet name");
    }
    if (!RegExpressions.name.hasMatch(value)) {
      return ("Invalid pet name");
    }

    return null;
  }


  String? petAgeValidator(String? value) {
    if(value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if(n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  String? postDescriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ("No post description");
    }

    return null;
  }
}