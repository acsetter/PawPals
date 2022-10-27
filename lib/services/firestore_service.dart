import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/pref_model.dart';

import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/utils/app_log.dart';

/// A service class to interface with the [FirebaseFirestore] plugin.
class FirestoreService {
  FirestoreService._();
  /// Reference UID of the current auth-user
  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// Reference to the [FirebaseFirestore] instance
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  static CollectionReference get _users => _db.collection('users');

  static CollectionReference get _prefs => _db.collection('preferences');

  static CollectionReference get _posts => _db.collection('posts');

  /// [DocumentReference] to the current user
  static DocumentReference<UserModel> get _userRef => _users.doc(_uid)
    .withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, _) => user.toFirestore());

  /// [DocumentReference] to the current user's feed-preferences
  static DocumentReference<PreferencesModel> get _prefRef => _prefs.doc(_uid)
      .withConverter(
        fromFirestore: PreferencesModel.fromFirestore,
        toFirestore: (PreferencesModel prefs, _) => prefs.toFirestore());

  /// A broadcast stream that notifies listeners when the [UserModel] of the
  /// logged in user updates/changes.
  static Stream<UserModel?> get userModelStream => _userRef.snapshots()
      .map((snapshot) => snapshot.data()).asBroadcastStream();

  /// A broadcast stream that notifies listeners when the [PreferencesModel] of
  /// the logged in user updates/changes.
  static Stream<PreferencesModel?> get prefModelStream => _prefRef.snapshots()
      .map((snapshot) => snapshot.data()).asBroadcastStream();
  
  static Future<UserModel?> getUserById(String uid) async {
    return await _users.doc(_uid)
      .withConverter(
        fromFirestore: UserModel.fromFirestore, 
        toFirestore: (UserModel user, _) => user.toFirestore())
      .get()
      .then(
        (snapshot) => snapshot.data(),  // UserModel or null on err
        onError: (e) => Logger.log(e.toString(), isError: true));
  }

  static Future<UserModel?> getUserByUsername(String username) async {
    return await _users.where("username", isEqualTo: username)
      .withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, _) => user.toFirestore()).get()
      .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.single.data();
        }
    }).catchError((e) { Logger.log(e.toString(), isError: true); });
  }

  /// Fetches the data of the currently logged-in user and returns a [UserModel].
  /// A null value will be returned if an error occurred.
  static Future<UserModel?> getUser() async {
    if (_uid == null) {
      // Theres no User logged-in.
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return null;
    }
    // The call to Firestore
    return await _userRef
      .get()
      .then(
        (snapshot) => snapshot.data(),  // UserModel or null on err
        onError: (e) => Logger.log(e.toString(), isError: true)
      );
  }

  /// Creates a User document from a [UserModel] in the Firestore Database.
  /// [UserModel.uid] is required to create the doc in the database.
  /// This method should only be called on user sign-up.
  static Future<bool> createUser(UserModel userModel) async {
    // Restrict creating/overwriting if not authorized.
    if (_uid == null || userModel.uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return false;
    }
    if (userModel.uid != _uid) {
      Logger.log("User being created does not match the user logged in", isError: true);
      return false;
    }
    // Set the timestamp to the moment the account was created.
    userModel.timestamp = DateTime.now().millisecondsSinceEpoch;
    return await _userRef
      .set(userModel)
      .then((res) {
          Logger.log("Firestore User doc created for ${userModel.email}");
          return createPreferences();
        },
        onError: (e) {
          Logger.log(e.toString(), isError: true);
          return false;
        });
  }

  /// Updates a User from a [UserModel] in the Firestore Database. <br/>
  /// **Note:** only the following fields are considered editable. All other
  /// fields will **NOT** be overwritten by this method:
  /// * [UserModel.first]
  /// * [UserModel.last]
  /// * [UserModel.photoUrl]
  /// * [UserModel.userPosts]
  /// * [UserModel.likedPosts]
  static Future<void> updateUser(UserModel userModel) async {
    // Restrict creating/overwriting if not authorized.
    if (_uid == null || userModel.uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return;
    }
    if (userModel.uid != _uid) {
      Logger.log("User being updated does not match the user logged in", isError: true);
      return;
    }

    await _userRef
      .update(userModel.toFirestoreUpdate())
      .then((res) => Logger.log("Firestore doc created for ${userModel.email}"),
        onError: (e) => Logger.log("Error creating Firestore doc for ${userModel.email}")
      );
  }

  /// Creates a [PreferencesModel] doc for a new user.
  /// Returns a bool indicating creation success.
  static Future<bool> createPreferences() async {
    if (_uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return false;
    }

    return await _prefRef
      .set(PreferencesModel())
      .then((res) {
          Logger.log("Firestore Pref doc created.");
          return true;
        },
        onError: (e) {
          Logger.log(e.toString(), isError: true);
          return false;
        });
  }

  /// A one-time fetch of the [PreferencesModel] for the logged-in user.
  static Future<PreferencesModel?> getPreferences() async {
    if (_uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return null;
    }

    return await _prefRef
      .get()
      .then((snapshot) => snapshot.data(),
        onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Update the [PreferencesModel] for the logged-in user.
  /// Returns a bool that indicates update success.
  static Future<bool> updatePreferences(PreferencesModel prefModel) async {
    if (_uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return false;
    }

    return await _prefRef
        .update(prefModel.toFirestore())
        .then(
          (value) {
            Logger.log("Preference doc updated.");
            return true;
          },
          onError: (e) {
            Logger.log(e.toString(), isError: true);
            return false;
          }
    );
  }

  static Future<PostModel?> getPostById(String postId) async {
    return null;
  }

  // static Future<List<PostModel?>?> getPostsFromIds(List<String> idList) async {
  //   await return _posts.where("uid", isEqualTo: )
  // }

  // static Future<List<PostModel?>?> getPostsByUser(UserModel userModel) async {
  //   return await _posts.where("uid", isEqualTo: userModel.uid).get()
  //       .then(
  //         (value) => value.docs.data(),
  //         onError: (e) => Logger.log(e.toString(), isError: true));
  // }

  // static Future<PostModel?> getLikedPosts() async {
  //   return null;
  // }

  // static Future<Image?> getImageFromUrl(String url) async {
  //   return null;
  // }

  /// Query all users and return if given username is unique.
  /// Returns null if error occurs.
  static Future<bool?> isUsernameUnique(String username) async {
    return await _users.where("username", isEqualTo: username).get().then(
      (res) => res.size < 1,
      onError: (e) {
        Logger.log(e.toString(), isError: true);
        return null;
      }
    );
  }
}