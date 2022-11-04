import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/utils/app_utils.dart';

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
      petTypes: data?["petTypes"]
        is Iterable ? AppUtils.petTypeListFromFirestore(data?["petTypes"]) : null,
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
    if (petTypes != null) "petTypes": AppUtils.petTypeListToFirestore(petTypes!),
    if (petGender != null) "petGender": petGender,
    if (minAge != null) "minAge": minAge,
    if (maxAge != null) "maxAge": maxAge,
    if (searchRadius != null) "searchRadius": searchRadius,
    if (isPetFriendly != null) "isPetFriendly": isPetFriendly,
    if (isKidFriendly != null) "isKidFriendly": isKidFriendly
  };

  /// Makes a copy of the [PreferencesModel] with expected changes.
  PreferencesModel copyWith({
    List<PetType>? petTypes,
    PetGender? petGender,
    int? minAge,
    int? maxAge,
    int? searchRadius,
    bool? isPetFriendly,
    bool? isKidFriendly,
  }) {
    return PreferencesModel(
      petTypes: petTypes ?? this.petTypes,
      petGender: petGender ?? this. petGender,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      searchRadius: searchRadius ?? this.searchRadius,
      isPetFriendly: isPetFriendly ?? this.isPetFriendly,
      isKidFriendly: isKidFriendly ?? this.isKidFriendly,
    );
  }
}