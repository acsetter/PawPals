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

  static String dateFromTimestamp(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute}";
  }
}
