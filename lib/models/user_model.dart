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
  List<String>? likedPosts;

  UserModel({
    required this.uid,
    this.email,
    this.username,
    this.first,
    this.last,
    this.photoUrl,
    this.timestamp,
    this.likedPosts
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
        timestamp: data?["timestamp"],
        likedPosts: data?["likedPosts"]
            is Iterable ? List.from(data?['likedPosts']) : null,
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
    if (timestamp!= null) "timestamp": timestamp,
    if (likedPosts != null) "likedPosts": likedPosts,
  };

  /// Converts the [UserModel] to json excluding fields unsafe to edit.
  Map<String, dynamic> toFirestoreUpdate() => {
    // TODO: Discuss if username should be editable with team.
    // if (username != null) "username": username,
    if (first != null) "first": first,
    if (last != null) "last": last,
    if (photoUrl != null) "photoUrl": photoUrl,
    if (likedPosts != null) "likedPosts": likedPosts,
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

 /// The copyWith method aids in the editing of user profile information.
 /// A copy of the UserModel is created and currently allows for the first
 /// and last name of the user to be changed and passed to the updateUser()
 ///  method to be updated in the database.
  UserModel copyWith({
    String? first,
    String? last,
    String? photoUrl,
    List<String>? userPosts,
    List<String>? likedPosts
  })  {
    return UserModel(
      uid: uid,
      email: email,
      first: first ?? this.first,
      last: last ?? this.last,
      photoUrl: photoUrl ?? this.photoUrl,
      likedPosts: likedPosts ?? this.likedPosts
    );
  }

  // static List<UserModel> listFromFirestore(list) =>
  //     List<UserModel>.from(list.map((x) => UserModel.fromFirestore(snapshot: x)));
}