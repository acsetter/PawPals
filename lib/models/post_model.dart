import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_pals/constants/app_types.dart';

/// Model that defines the post data stored in the database.
class PostModel {
  final String? postId;
  final String? uid;
  String? timestamp;
  String? postDescription;
  double? longitude;
  double? latitude;
  String? geoHash;
  String? petName;
  int? petAge;
  PetGender? petGender;
  String? petPhotoUrl;
  bool? isKidFriendly;
  bool? isPetFriendly;

  PostModel({
    required this.postId,
    required this.uid,
    this.timestamp,
    this.postDescription,
    this.longitude,
    this.latitude,
    this.geoHash,
    this.petName,
    this.petAge,
    this.petGender,
    this.petPhotoUrl,
    this.isKidFriendly,
    this.isPetFriendly,
  });

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
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
      petAge: data?["petAge"],
      petGender: data?["petGender"],
      petPhotoUrl: data?["petPhotoUrl"],
      isKidFriendly: data?["isKidFriendly"],
      isPetFriendly: data?["isPetFriendly"],
    );
  }

  Map<String, dynamic> toFirestore() => {
    "postId": postId,
    "timestamp": timestamp,
    "postDescription": postDescription,
    "longitude": longitude,
    "latitude": latitude,
    "geoHash": geoHash,
    "petName": petName,
    "petAge": petAge,
    "petGender": petGender,
    "petPhotoUrl": petPhotoUrl,
    "isKidFriendly": isKidFriendly,
    "isPetFriendly": isPetFriendly,
  };
}