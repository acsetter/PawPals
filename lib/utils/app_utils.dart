import 'package:paw_pals/constants/app_types.dart';
import 'app_log.dart';

class AppUtils {
  AppUtils._();

  static PetType? petTypeFromString(String? str) {
    switch(str) {
      case "cat":
        return PetType.cat;
      case "dog":
        return PetType.dog;
      default:
        Logger.log("PetType from str returned null.", isError: true);
        return null;
    }
  }

  static PetGender? petGenderFromString(String? str) {
    switch(str) {
      case "male":
        return PetGender.male;
      case "female":
        return PetGender.female;
      default:
        Logger.log("PetGender from str returned null.", isError: true);
        return null;
    }
  }

  static List<PetType> petTypeListFromFirestore(List<String> list) =>
    List<PetType>.from(list.map((x) => petTypeFromString(x)));

  static List<String> petTypeListToFirestore(List<PetType> list) =>
    List<String>.from(list.map((x) => x.name));

  static List<String> petGenderListToFirestore(List<PetGender> list) =>
    List<String>.from(list.map((x) => x.name));

  static String dateFromTimestamp(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute}";
  }

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
