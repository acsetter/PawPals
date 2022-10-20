import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/app_types.dart';

/// Model that defines the preferences data stored in the database.
class Preferences {
  List<PetType>? petTypes;
  PetGender? petGender;
  int? minAge;
  int? maxAge;
  int? searchRadius;
  bool? isPetFriendly;
  bool? isKidFriendly;

  Preferences({
    this.petTypes,
    this.petGender,
    this.minAge,
    this.maxAge,
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
      minAge: data?["minAge"],
      maxAge: data?["maxAge"],
      searchRadius: data?["searchRadius"],
      isPetFriendly: data?["isPetFriendly"],
      isKidFriendly: data?["isKidFriendly"],
    );
  }

  Map<String, dynamic> toFirestore() => {
    "petTypes": petTypes,
    "petGender": petGender,
    "minAge": minAge,
    "maxAge": maxAge,
    "searchRadius": searchRadius,
    "isPetFriendly": isPetFriendly,
    "isKidFriendly": isKidFriendly
  };
}