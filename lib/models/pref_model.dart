import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_pals/constants/app_types.dart';

/// Model that defines the feed-preferences data stored in the database.
/// **WARNING:** [PreferencesModel] fields are not null-safe and need to be handled as such.
class PreferencesModel {
  List<PetType>? petTypes;
  PetGender? petGender;
  int? minAge;
  int? maxAge;
  int? searchRadius;
  bool? isPetFriendly;
  bool? isKidFriendly;

  PreferencesModel({
    this.petTypes,
    this.petGender,
    this.minAge,
    this.maxAge,
    this.searchRadius,
    this.isPetFriendly,
    this.isKidFriendly
  });

  /// Converts a [DocumentSnapshot] from [FirebaseFirestore] to a [PreferencesModel].
  factory PreferencesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();

    return PreferencesModel(
      petTypes: data?["petTypes"],
      petGender: data?["petGender"],
      minAge: data?["minAge"],
      maxAge: data?["maxAge"],
      searchRadius: data?["searchRadius"],
      isPetFriendly: data?["isPetFriendly"],
      isKidFriendly: data?["isKidFriendly"],
    );
  }

  /// Converts the [PreferencesModel] to json with including all non-null fields.
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