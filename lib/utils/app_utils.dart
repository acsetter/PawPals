import 'package:paw_pals/constants/app_types.dart';

class AppUtils {
  AppUtils._();

  /// Converts a given string to a [PetType].
  /// Returns null if invalid or given string is null.
  static PetType? petTypeFromString(String? str) {
    switch(str) {
      case "cat":
        return PetType.cat;
      case "dog":
        return PetType.dog;
      default:
        return null;
    }
  }

  /// Converts a given string to a [PetGender].
  /// Returns null if invalid or given string is null.
  static PetGender? petGenderFromString(String? str) {
    switch(str) {
      case "male":
        return PetGender.male;
      case "female":
        return PetGender.female;
      default:
        return null;
    }
  }

  /// A timestamp in the format 'mm/dd/yyyy HH:MM'
  static String dateFromTimestamp(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute}";
  }

  /// A user-friendly relative timestamp that compares a given time in
  /// milliseconds to the current time.
  static String relDateFromTimestamp(int timestamp) {
    int dT = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (dT < 60000) return "Just Now";

    int m = dT ~/ 60000;
    if (m < 60) return "$m minute${m > 1 ? 's' : ''} ago";

    int h = dT ~/ 3600000;
    if (h < 24) return "$h hour${h > 1 ? 's' : ''} ago";

    int d = dT ~/ 86400000;
    if (d < 7) return "$d day${d > 1 ? 's' : ''} ago";

    int w = dT ~/ 604800000;
    if (w < 3) return "$w week${w > 1 ? 's' : ''} ago";

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "on ${date.month}/${date.day}/${date.year}";
  }
}
