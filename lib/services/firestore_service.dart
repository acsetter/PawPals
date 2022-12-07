import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_pals/constants/app_info.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/pref_model.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/services/location_services.dart';
import 'package:paw_pals/services/storage_service.dart';
import 'package:paw_pals/utils/app_log.dart';

/// A service class to interface with the [FirebaseFirestore] plugin.
class FirestoreService {
  FirestoreService._();
  /// Reference UID of the current auth-user
  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// Reference to the [FirebaseFirestore] instance
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  /// Reference to the users collection in Firestore.
  static CollectionReference get _users => _db.collection('users');

  /// Reference to the user preferences collection in Firestore.
  static CollectionReference get _prefs => _db.collection('preferences');

  /// Reference to the posts collection in Firestore.
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

  /// A broadcast stream that notifies listeners when the list of Posts that
  /// belong to the app user updates/changes.
  static Stream<List<PostModel>?> get appUserPostsStream => _posts
      .where("uid", isEqualTo: _uid)
      .withConverter(
      fromFirestore: PostModel.fromFirestore,
      toFirestore: (snapshot, _) => snapshot.toFirestore())
      .snapshots()
      .map((snapshot) => List<PostModel>.from(snapshot.docs.map((doc) => doc.data())))
      .asBroadcastStream();

  /// A broadcast stream that notifies listeners when the list of Posts that
  /// belong to the 'uid' of the expected [UserModel] updates/changes.
  static Stream<List<PostModel>?> userPostsStream(UserModel userModel) => _posts
      .where("uid", isEqualTo: userModel.uid ?? "_")
      .withConverter(
      fromFirestore: PostModel.fromFirestore,
      toFirestore: (snapshot, _) => snapshot.toFirestore())
      .snapshots()
      .map((snapshot) => List<PostModel>.from(snapshot.docs.map((doc) => doc.data())))
      .asBroadcastStream();

  /// A broadcast stream that notifies listeners when the list of Posts that
  /// belong to the 'likedPosts' of the expected [UserModel] updates/changes.
  static Stream<List<PostModel>?> userLikedPostsStream(UserModel userModel) => _posts
      .where("postId", whereIn: userModel.likedPosts ?? ["_"])
      .withConverter(
        fromFirestore: PostModel.fromFirestore,
        toFirestore: (snapshot, _) => snapshot.toFirestore())
      .snapshots()
      .map((snapshot) => List<PostModel>.from(snapshot.docs.map((doc) => doc.data())))
      .asBroadcastStream();

  /// Fetches the [UserModel] from the expected uid from Firestore.
  static Future<UserModel?> getUserById(String uid) async {
    return await _users.doc(uid)
      .withConverter(
        fromFirestore: UserModel.fromFirestore, 
        toFirestore: (UserModel user, _) => user.toFirestore())
      .get()
      .then(
        (snapshot) => snapshot.data(),  // UserModel or null on err
        onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Fetches the [UserModel] from the expected username from Firestore.
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
      Logger.noUserError();
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
      Logger.noUserError();
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
          return _createPreferences();
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
  /// * [UserModel.photoUrl] <strong>Automatically updated; do not edit</strong>
  /// * [UserModel.likedPosts]
  static Future<bool> updateUser({required UserModel userModel, File? file}) async {
    // Restrict creating/overwriting if not authorized.
    if (_uid == null) {
      Logger.log("No User is logged into Firebase Auth.", isError: true);
      return false;
    }
    if (userModel.uid != _uid) {
      Logger.log("User being updated does not match the user logged in", isError: true);
      return false;
    }

    return await _userRef
        .update(userModel.copyWith(photoUrl: file != null ? await StorageService.uploadProfileImage(file):null)
        .toFirestoreUpdate())
        .then((res) {
      Logger.log("Firestore doc updated for ${userModel.email}");
      return true;
    },
        onError: (e) {
          Logger.log("Error updating Firestore doc for ${userModel.email}");
          return false;
        }
    );
  }

  /// Creates a [PreferencesModel] doc for a new user.
  /// Returns a bool indicating creation success.
  static Future<bool> _createPreferences() async {
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
      Logger.noUserError();
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

  /// Requests the [PostModel] of the specified postId from the database.
  static Future<PostModel?> getPostById(String postId) async {
    return await _posts.doc(postId)
        .withConverter(
          fromFirestore: PostModel.fromFirestore,
          toFirestore: (PostModel postModel, _) => postModel.toFirestore())
        .get()
        .then(
          (res) => res.data(),
          onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Creates a post from an expected [PostModel] in the database and stores an
  /// associated photo from an expected [File] in Firebase Storage. The postId,
  /// uid of the logged-in user, petPhotoUrl, and timestamp are automatically
  /// attached and should not be specified when passing the PostModel to this
  /// method. A boolean indicating success or failure is returned.
  static Future<bool> createPost(PostModel postModel, File file) async {
    if (_uid == null) {
      Logger.noUserError();
      return false;
    }
    // creates a ref to a new post and generates a unique postID
    var postRef = _posts.doc()
        .withConverter(
          fromFirestore: PostModel.fromFirestore,
          toFirestore: (PostModel postModel, _) => postModel.toFirestore());

    // attach data generated by Firestore to the new post
    OurLocation currentLocation = await LocationService.getLocation();
    PostModel newPost = postModel.copyWith(
      postId: postRef.id,
      uid: _uid,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      petPhotoUrl: await StorageService.uploadPostImage(file, postRef.id),
      longitude: currentLocation.longitude,
      latitude: currentLocation.latitude,
      geoHash: currentLocation.geoHash
    );

    if (newPost.petPhotoUrl == null) {
      Logger.log("Unable to upload post image; aborting post creation.", isError: true);
      return false;
    }

    return await postRef
        .set(newPost)
        .then((res) {
          Logger.log("Post ${newPost.postId} created.");
          return true;
        }, onError: (e) {
          Logger.log(e.toString(), isError: true);
          return false;
    });
  }

  /// Deletes a post that the user has created from the database
  static Future<bool> deletePosts(PostModel postModel) {
    return _posts
        .doc(postModel.postId)
        .delete()
        .then((res) {
      Logger.log("Post ${postModel.postId} deleted.");
      return true;
    }, onError: (e)
    {
      Logger.log(e.toString(), isError: true);
      return false;
    }
    );
  }

  /// Gets a list of [PostModel]s from a list of postId strings from the
  /// database.
  static Future<List<PostModel>?> getPostsFromIds(List<String>? idList) async {
    return await _posts
        .where("uid", whereIn: idList)
        .withConverter(
          fromFirestore: PostModel.fromFirestore,
          toFirestore: (snapshot, _) => snapshot.toFirestore())
        .get()
        .then(
          (value) => List<PostModel>.from(value.docs.map((snapshot) => snapshot.data())),
          onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Queries the Firestore post collection for all posts associated with the
  /// uid of the expected [UserModel] and returns a list of [PostModel]s.
  static Future<List<PostModel>?> getPostsByUser(String uid) async {
    return await _posts
        .where("uid", isEqualTo: uid)
        .orderBy("timestamp", descending: true)
        .withConverter(
          fromFirestore: PostModel.fromFirestore,
          toFirestore: (snapshot, _) => snapshot.toFirestore())
        .get()
        .then(
          (snapshot) => List<PostModel>.from(snapshot.docs.map((snapshot) => snapshot.data())),
          onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Gets a list of [PostModel]s from an expected [UserModel] from the database.
  static Future<List<PostModel>?> likedPostsByUser(UserModel userModel) async {
    List<String>? qList = userModel.likedPosts?.toList();
    List<PostModel> posts = [];
    if (qList == null || qList.isEmpty) return null;

    while (qList.isNotEmpty) {
      int n = min(qList.length, 10);
      await _posts
          .where("postId", whereIn: qList.sublist(0, n).toList())
          // .orderBy("timestamp", descending: true)
          .withConverter(
          fromFirestore: PostModel.fromFirestore,
          toFirestore: (snapshot, _) => snapshot.toFirestore())
          .get()
          .then(
              (snapshot) => posts.addAll(snapshot.docs.map((doc) => doc.data())),
          onError: (e) => Logger.log(e.toString(), isError: true));

      qList.removeRange(0, n);
    }

    return posts;
  }

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

  /// Queries the Firestore post collection for all posts that satisfy the query
  /// constraints specified by the expected [PreferencesModel]. Note: due to
  /// Firestore limitations, search radius cannot be queried and must be
  /// filtered client side.
  static Future<List<PostModel>?> getFeedPosts(PreferencesModel? prefModel) async {
    return LocationService.updatePostListWithSearchRadius(
      oldPostModelList: await _posts
      // .where("uid", isNotEqualTo: _uid)
      .where("isKidFriendly", isEqualTo: prefModel?.isKidFriendly == true ? true : null)
      .where("isPetFriendly", isEqualTo: prefModel?.isPetFriendly == true ? true : null)
      .where("petAge", isGreaterThanOrEqualTo: prefModel?.minAge ?? AppInfo.minPetAge)
      .where("petAge", isLessThanOrEqualTo: prefModel?.maxAge ?? AppInfo.maxPetAge)
      .where("petGender", isEqualTo: prefModel?.petGender?.name)
      .where("petType", isEqualTo: prefModel?.petType?.name)
      .withConverter(
        fromFirestore: PostModel.fromFirestore,
        toFirestore: (snapshot, _) => snapshot.toFirestore())
      .get()
      .then(
        (value) => List<PostModel>.from(value.docs.map((snapshot) => snapshot.data())),
        onError: (e) => Logger.log(e.toString())),
      userPreferenceModel: prefModel);
    
  }
}