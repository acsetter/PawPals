import 'package:cloud_firestore/cloud_firestore.dart';

/// Model that defines the user data stored in the database. <br/>
/// **WARNING:** [UserModel] fields are not null-safe and need to be handled as such.
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

  /// Converts a [DocumentSnapshot] from [FirebaseFirestore] to a [UserModel].
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

  /// Converts the [UserModel] to json with including all non-null fields.
  Map<String, dynamic> toFirestore() => {
    "uid": uid,
    if (username != null) "username": username,
    if (email != null) "email": email,
    if (first != null) "first": first,
    if (last != null) "last": last,
    if (photoUrl != null) "photoUrl": photoUrl,
    if (timestamp!= null) "timestamp": timestamp
  };

  /// Converts the [UserModel] to json excluding fields unsafe to edit.
  Map<String, dynamic> toFirestoreUpdate() => {
    // TODO: Discuss if username should be editable with team.
    // if (username != null) "username": username,
    if (first != null) "first": first,
    if (last != null) "last": last,
    if (photoUrl != null) "photoUrl": photoUrl,
  };

  bool isEqualTo(UserModel userModel) {
    return uid == userModel.uid &&
      username == userModel.username &&
      email == userModel.email &&
      first == userModel.first &&
      last == userModel.last &&
      photoUrl == userModel.photoUrl &&
      timestamp == userModel.timestamp;
  }

  // static List<UserModel> listFromJson(list) =>
  //     List<UserModel>.from(list.map((x) => UserModel.fromJson(snapshot: x)));
}