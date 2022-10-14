import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/utils/app_log.dart';

/// The controller/access-point for the user of the app.
/// This class is a singleton accessed by calling `AppUser.instance`. The signleton is
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

  final StreamController<UserModel?> _controller = StreamController<UserModel?>.broadcast();
  UserModel? _userModel;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<UserModel?>? _firestoreSub;

  AppUser._() {
    _updateUser();
    _subscribe();
    addListener(_updateStream);
  }

  /// Returns the instance of the [AppUser].
  static AppUser get instance => _instance;

  /// Notifies about changes to the authenticated user's [UserModel].
  Stream<UserModel?> appUserChanges() => _controller.stream;

  /// Get the authenticated user's [UserModel].
  UserModel? get userModel => _userModel;

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
  }

  void _unsubscribe() {
    if (_authSub != null) {
      _authSub!.cancel();
      _authSub = null;
    }
    if (_firestoreSub != null) {
      _firestoreSub!.cancel();
      _firestoreSub = null;
    }
  }

  void _updateUser() async {
    UserModel? newUserModel = await FirestoreService.getUser();
    if (newUserModel == null) return;

    if (_userModel == null) {
      _userModel = newUserModel;
      notifyListeners();
    } else if (!newUserModel.isEqualTo(_userModel!)) {
      _userModel = newUserModel;
      notifyListeners();
    }
  }

  void _updateStream() {
    // Called to send the UserModel down the stream
    _controller.sink.add(_userModel);
  }

  @override
  void dispose() {
    // No need to call dispose() since this singleton is designed to live
    // the entire app cycle, but I added a cleanup routine just in case.
    _unsubscribe();
    removeListener(_updateStream);
    Logger.log('AppUser disposed.');
    super.dispose();
  }
}