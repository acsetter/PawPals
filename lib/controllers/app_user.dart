import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/utils/app_log.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../models/post_model.dart';

/// The data-controller for the user of the app.
/// This class is a singleton accessed by calling `AppUser.instance`.
///
/// [AppUser] listens to both [FirebaseAuth] and [FirebaseFirestore] for changes
/// to the authenticated user through two separate streams. When any significant
/// change occurs, listeners of the [AppUser] or it's stream are notified and
/// the singleton's [UserModel] is updated.
///
/// <br/> **Motivation**:
/// * Loosely-coupled state-management through a common & convenient interface.
/// * Highly-governed database management to prevent redundant queries.
/// * The ability to subscribe to [UserModel] changes via listeners or a stream.
class AppUser extends ChangeNotifier {
  static final AppUser _instance = AppUser._();

  final StreamController<UserModel?> _userController = StreamController<UserModel?>.broadcast();
  final StreamController<List<PostModel>?> _likedPostsController = StreamController<List<PostModel>>.broadcast();
  final StreamController<List<PostModel>?> _userPostsController = StreamController<List<PostModel>?>.broadcast();
  UserModel? _userModel;
  List<PostModel>? _userPosts;
  List<PostModel>? _likedPosts;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<UserModel?>? _firestoreSub;
  StreamSubscription<List<PostModel>?>? _userPostsSub;

  AppUser._() {
    _updateUser();
    _subscribe();
    addListener(_updateUserStream);
  }

  /// Returns the instance of the [AppUser].
  static AppUser get instance => _instance;

  /// Notifies about changes to the authenticated user's [UserModel].
  Stream<UserModel?> appUserChanges() => _userController.stream;

  Stream<List<PostModel>?> likedPostsStream() => _likedPostsController.stream;

  Stream<List<PostModel>?> userPostsStream() => _userPostsController.stream;

  /// Get the authenticated user's [UserModel].
  UserModel? get userModel => _userModel;

  /// Get the user's liked [PostModel]s.
  List<PostModel>? get likedPosts => _likedPosts;

  /// Get the user's [PostModel]s.
  List<PostModel>? get userPosts => _userPosts;

  void _subscribe() {
    // Listen for changes to the authenticated user
    _authSub = FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        // will query user on login/ sign-up
        _updateUser();
      } else {
        // Nullify the user if not authenticated
        if (_userModel != null) {
          _userModel = null;
          notifyListeners();
        }
      }
    });
    // Listen for any Firestore changes to the user's UserModel
    _firestoreSub = FirestoreService.userModelStream.listen((userModel) {
      _userModel = userModel;
      notifyListeners();
    });

    _userPostsSub = FirestoreService.appUserPostsStream.listen((userPosts) {
      _userPosts = userPosts;
      _updateUserPostsStream();
    });
  }

  void _unsubscribe() {
    if (_authSub != null) {
      _authSub?.cancel();
      _authSub = null;
    }
    if (_firestoreSub != null) {
      _firestoreSub!.cancel();
      _firestoreSub = null;
    }
    _userController.close();
  }

  void _updateUser() async {
    UserModel? newUserModel = await FirestoreService.getUser();
    if (newUserModel == null) return;
    _userModel ??= newUserModel;
    if (!newUserModel.isEqualTo(_userModel!)) {
      _userModel = newUserModel;
    }
    notifyListeners();
  }

  void _updateUserStream() {
    // send the updated UserModel to stream listeners.
    _userController.sink.add(_userModel);
    _updateLikedPostsStream();
    _updateUserPostsStream();
  }

  void _updateLikedPostsStream() async {
    if (userModel != null) {
      _likedPosts = await FirestoreService.likedPostsByUser(userModel!);
      _likedPostsController.sink.add(_likedPosts);
    }
  }

  void _updateUserPostsStream() async {
    if (userModel != null) {
      // _userPosts = await FirestoreService.getPostsByUser(userModel!);
      _userPostsController.sink.add(_userPosts);
    }
  }

  @override
  void dispose() {
    // No need to call dispose() since this singleton is designed to live
    // the entire app cycle, but I added a cleanup routine just in case.
    _unsubscribe();
    removeListener(_updateUserStream);
    Logger.log('AppUser disposed.');
    super.dispose();
  }
}