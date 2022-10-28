import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_pals/constants/app_types.dart';

/// Model that defines the post data stored in the database.
/// **WARNING:** [PostModel] fields are not null-safe and need to be handled as such.
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

  /// Converts a [DocumentSnapshot] from [FirebaseFirestore] to a [PostModel].
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

  /// Converts the [PostModel] to json with including all non-null fields.
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

  static List<PostModel> post = [
    PostModel(
      postId: "1",
      uid: "1",
      postDescription: "Bob is an adventurous Cat!",
      petName: "Bob",
      petAge: 7,
      petPhotoUrl: 'assets/images/tabby_cat.jpg',


    ),
    PostModel(
      postId: "2",
      uid: "2",
      postDescription: "Carl likes to sleep and chew on bones!",
      petName: "Carl",
      petAge: 5,
      petPhotoUrl: 'assets/images/corgi.jpg',
    ),
    PostModel(
      postId: "3",
      uid: "3",
      postDescription: "Doug likes alot of treats!",
      petName: "Doug",
      petAge: 4,
      petPhotoUrl: 'assets/images/english_bulldog.jpg',
    ),
    PostModel(
      postId: "4",
      uid: "4",
      postDescription: "Earl is Lazy!",
      petName: "Earl",
      petAge: 9,
      petPhotoUrl: 'assets/images/siamese_cat.jpg',
    ),
  ];

// static List<PostModel> listFromFirestore(list) =>
//     List<PostModel>.from(list.map((x) => PostModel.fromFirestore(snapshot: x)));
}