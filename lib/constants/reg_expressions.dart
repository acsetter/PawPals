/// Regular Expressions go here. Be sure to mark them as static!
/// Some useful examples: https://github.com/suragch/string_validator/blob/master/lib/src/validator.dart
class RegExpressions {
  RegExpressions._();

  /// Strings with only characters in the Alphabet.
  static RegExp alpha = RegExp(r'^[a-zA-Z]+$');

  static RegExp name = RegExp(r'^[a-zA-Z- ]+$');

  /// Strings that are only valid email addresses.
  static RegExp email = RegExp(r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  /// Strings that have at least one upper character.
  static RegExp oneUpperChar = RegExp(r'^(?=.*?[A-Z])');

  /// Strings that have at least one lower character.
  static RegExp oneLowerChar = RegExp(r'^(?=.*?[a-z])');

  /// Strings that have at least one numeric digit.
  static RegExp oneDigit = RegExp(r'^(?=.*?[0-9])');

  /// String that have at least one special character.
  static RegExp oneSpecialChar = RegExp(r'^(?=.*?[.#?!@$%^&*|_-])');

  /// Strings that have 8 or more characters.
  static RegExp eightChars = RegExp(r'^.{8,}');
  
  /// Strings that are only valid usernames.
  static RegExp username = RegExp(r'^[a-z0-9_-]+$');

  /// Strings that allow spaces, and punctuation for post descriptions.
  static RegExp postDescription = RegExp(r'^[a-zA-Z0-9.?!_ -]*$');
}