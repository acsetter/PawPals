import '../constants/app_types.dart';

class Preferences {
  List<PetType>? petTypes;
  PetGender? petGender;
  List<AgeType>? ageRanges;
  int? searchRadius;
  bool? isPetFriendly;
  bool? isKidFriendly;

  Preferences({
    this.petTypes,
    this.petGender,
    this.ageRanges,
    this.searchRadius,
    this.isPetFriendly,
    this.isKidFriendly
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    petTypes: json["petTypes"],
    petGender: json["petGender"],
    ageRanges: json["ageRanges"],
    searchRadius: json["searchRadius"],
    isPetFriendly: json["isPetFriendly"],
    isKidFriendly: json["isKidFriendly"],
  );

  Map<String, dynamic> toJson() => {
    "petTypes": petTypes,
    "petGender": petGender,
    "ageRanges": ageRanges,
    "searchRadius": searchRadius,
    "isPetFriendly": isPetFriendly,
    "isKidFriendly": isKidFriendly
  };
}