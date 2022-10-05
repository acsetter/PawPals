import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_pals/models/user_model.dart';

import '../models/post_model.dart';
import '../utils/app_log.dart';

/// A service class for accessing the database over the network.
class FirestoreService {
  /// Reference UID of the current auth-user
  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// Reference to the [FirebaseFirestore] instance
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  /// [DocumentReference] to the current user
  static DocumentReference<UserModel> get _userRef => _db.collection('user')
      .doc(_uid)
      .withConverter(
    fromFirestore: UserModel.fromFirestore,
    toFirestore: (UserModel user, _) => user.toFirestore(),
  );

  /// Fetches the data of the currently logged-in user and returns a [UserModel].
  /// A null value will be returned if an error occurred.
  static Future<UserModel?> getUser() async {
    if (_uid == null) {
      // Theres no User logged-in.
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return null;
    }
    // The call to Firestore
    final docSnap = await _userRef.get();
    if (docSnap.data() == null) {
      // Log if something went wrong
      Logger.log("Error fetching User data", isError: true);
    }
    // returns UserModel or null if something went wrong.
    return docSnap.data();
  }

  /// Creates or Overwrites the User
  static Future<void> setUser(UserModel userModel) async {
    if (_uid == null || userModel.uid == null || userModel.uid != _uid) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return;
    }

    await _userRef.set(userModel);
  }

  static Future<PostModel?> getPostById(String postId) async {
    return null;
  }

  static Future<List<PostModel>?> getPostsByUser(UserModel userModel) async {
    return null;
  }

  static Future<PostModel?> getLikedPosts() async {
    return null;
  }

  static Future<Image?> getImageFromUrl(String url) async {
    return null;
  }

}