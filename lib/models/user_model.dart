import 'package:cloud_firestore/cloud_firestore.dart';

/// Model that defines the user data stored in the database.
class UserModel {
  final String? uid;
  String? email;
  String? username;
  String? first;
  String? last;
  String? photoUrl;
  int? timestamp;

  UserModel({
    required this.uid,
    this.email,
    this.username,
    this.first,
    this.last,
    this.photoUrl,
    this.timestamp
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return UserModel(
        uid: data?["uid"],
        email: data?["email"],
        username: data?["username"],
        first: data?["first"],
        last: data?["last"],
        photoUrl: data?["photoUrl"],
        timestamp: data?["timestamp"]
    );
  }

  Map<String, dynamic> toFirestore() => {
    "username": username,
    "first": first,
    "last": last,
    "photoUrl": photoUrl,
    "timestamp": timestamp
  };

  // static List<UserModel> listFromJson(list) =>
  //     List<UserModel>.from(list.map((x) => UserModel.fromJson(snapshot: x)));
}