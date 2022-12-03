import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/utils/app_utils.dart';

/// Model that defines the post data stored in the database.
/// **WARNING:** [PostModel] fields are not null-safe and need to be handled as such.
class PostModel {
  String? postId;
  String? uid;
  int? timestamp;
  String? postDescription;
  double? longitude;
  double? latitude;
  String? geoHash;
  String? petName;
  PetType? petType;
  int? petAge;
  PetGender? petGender;
  String? petPhotoUrl;
  bool? isKidFriendly;
  bool? isPetFriendly;
  String? email;
  String? username;

  PostModel({
    this.postId,
    this.uid,
    this.timestamp,
    this.postDescription,
    this.longitude,
    this.latitude,
    this.geoHash,
    this.petName,
    this.petType,
    this.petAge,
    this.petGender,
    this.petPhotoUrl,
    this.isKidFriendly,
    this.isPetFriendly,
    this.email,
    this.username,
  });

  /// Converts a [DocumentSnapshot] from [FirebaseFirestore] to a [PostModel].
  factory PostModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return PostModel(
      postId: data?["postId"],
      uid: data?["uid"],
      timestamp: data?["timestamp"],
      postDescription: data?["postDescription"],
      longitude: data?["longitude"],
      latitude: data?["latitude"],
      geoHash: data?["geoHash"],
      petName: data?["petName"],
      petType: AppUtils.petTypeFromString(data?["petType"]),
      petAge: data?["petAge"],
      petGender: AppUtils.petGenderFromString(data?["petGender"]),
      petPhotoUrl: data?["petPhotoUrl"],
      isKidFriendly: data?["isKidFriendly"],
      isPetFriendly: data?["isPetFriendly"],
      email: data?["email"],
      username: data?["username"],
    );
  }

  /// Converts the [PostModel] to json with including all non-null fields.
  Map<String, dynamic> toFirestore() =>
      {
        if (postId != null) "postId": postId,
        if (uid != null) "uid": uid,
        if (timestamp != null) "timestamp": timestamp,
        if (postDescription != null) "postDescription": postDescription,
        if (longitude != null) "longitude": longitude,
        if (latitude != null) "latitude": latitude,
        if (geoHash != null) "geoHash": geoHash,
        if (petName != null) "petName": petName,
        if (petType != null) "petType": petType!.name,
        if (petAge != null) "petAge": petAge,
        if (petGender != null) "petGender": petGender!.name,
        if (petPhotoUrl != null) "petPhotoUrl": petPhotoUrl,
        if (isKidFriendly != null) "isKidFriendly": isKidFriendly,
        if (isPetFriendly != null) "isPetFriendly": isPetFriendly,
        if (email != null) "email": email,
        if (username != null) "username": username,
      };

  PostModel copyWith({
    String? postId,
    String? uid,
    int? timestamp,
    double? longitude,
    double? latitude,
    String? geoHash,
    String? postDescription,
    String? petName,
    PetType? petType,
    int? petAge,
    PetGender? petGender,
    String? petPhotoUrl,
    bool? isKidFriendly,
    bool? isPetFriendly,
    String? email,
    String? username,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      timestamp: timestamp ?? this.timestamp,
      postDescription: postDescription ?? this.postDescription,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      geoHash: geoHash ?? this.geoHash,
      petName: petName ?? this.petName,
      petType: petType ?? this.petType,
      petAge: petAge ?? this.petAge,
      petGender: petGender ?? this.petGender,
      petPhotoUrl: petPhotoUrl ?? this.petPhotoUrl,
      isKidFriendly: isKidFriendly ?? this.isKidFriendly,
      isPetFriendly: isPetFriendly ?? this.isPetFriendly,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  static List<PostModel> listFromFirestore(list) =>
      List<PostModel>.from(list.map((x) => PostModel.fromFirestore(x, null)));

  @override
  String toString() {
    return "postId: $postId \n"
        "uid: $uid \n"
        "timestamp: ${timestamp == null ? "null" : AppUtils.dateFromTimestamp(
        timestamp!)} \n"
        "postDescription: $postDescription \n"
        "longitude: $longitude \n"
        "latitude: $latitude \n"
        "geoHash: $geoHash \n"
        "petName: $petName \n"
        "petType: ${petType?.name} \n"
        "petAge: $petAge \n"
        "petGender ${petGender?.name} \n"
        "petPhotoUrl: $petPhotoUrl \n"
        "isKidFriendly: $isKidFriendly \n"
        "isPetFriendly: $isPetFriendly \n"
        "email: $email \n"
        "username: $username \n";
  }

}