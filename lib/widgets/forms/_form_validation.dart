import 'package:flutter/src/widgets/framework.dart';

import '../../constants/reg_expressions.dart';
import '../../utils/app_localizations.dart';

/// Form validation functions
mixin FormValidation<T extends StatefulWidget> on State<T> {
  String fetch(String key) => AppLocalizations.of(context).translate(key);

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
     return fetch("errors.empty-email");
    } else if (!RegExpressions.email.hasMatch(value)) {
      return fetch("errors.invalid-email");
    }

    return null;
  }

  /// Validate password for login.
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return fetch("errors.empty-email");
    }
    if (!RegExpressions.eightChars.hasMatch(value)) {
      return fetch("errors.weak-password");
    }

    return null;
  }

  /// Validate password for signup.
  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return fetch("errors.empty-password");
    }
    if (!RegExpressions.eightChars.hasMatch(value)) {
      return fetch("errors.weak-password");
    }
    if (!RegExpressions.oneUpperChar.hasMatch(value)) {
      return fetch("errors.no-upper-char-password");
    }
    if (!RegExpressions.oneLowerChar.hasMatch(value)) {
      return fetch("errors.no-lower-char-password");
    }
    if(!RegExpressions.oneDigit.hasMatch(value)) {
      return fetch("errors.no-number-char-password");
    }
    if (!RegExpressions.oneSpecialChar.hasMatch(value)) {
      return fetch("errors.no-special-char-password");
    }

    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return fetch("errors.empty-username");
    }
    if (!RegExpressions.username.hasMatch(value)) {
      return fetch("errors.invalid-username");
    }

    return null;
  }

  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return fetch("errors.empty-first-name");
    }
    if (!RegExpressions.alpha.hasMatch(value)) {
      return fetch("errors.invalid-name");
    }

    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return fetch("errors.empty-last-name");
    }
    if (!RegExpressions.alpha.hasMatch(value)) {
      return fetch("errors.invalid-name");
    }

    return null;
  }
}