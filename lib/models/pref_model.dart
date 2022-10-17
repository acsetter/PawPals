import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/app_types.dart';

/// Model that defines the preferences data stored in the database.
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

  factory Preferences.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return Preferences(
      petTypes: data?["petTypes"],
      petGender: data?["petGender"],
      ageRanges: data?["ageRanges"],
      searchRadius: data?["searchRadius"],
      isPetFriendly: data?["isPetFriendly"],
      isKidFriendly: data?["isKidFriendly"],
    );
  }

  Map<String, dynamic> toFirestore() => {
    "petTypes": petTypes,
    "petGender": petGender,
    "ageRanges": ageRanges,
    "searchRadius": searchRadius,
    "isPetFriendly": isPetFriendly,
    "isKidFriendly": isKidFriendly
  };
}