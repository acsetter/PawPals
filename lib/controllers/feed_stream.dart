import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/controllers/app_user.dart';

import '../models/post_model.dart';

class FeedStream extends ChangeNotifier {
  static final _instance = FeedStream._();
  static FeedStream get instance => _instance;

  final StreamController<List<PostModel>?> _feedController = StreamController<List<PostModel>?>.broadcast();
  List<PostModel>? _postModels;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<List<PostModel>>? _querySub;

  FeedStream._() {
    addListener(_updateStream);
  }

  void _subscribe() {
    AppUser.instance.appUserChanges().listen((userModel) {
      if (userModel != null) {
        // user logged in
      }
    });
    // Listen for changes to the authenticated user
    // _authSub = FirebaseAuth.instance.userChanges().listen((user) {
    //   if (user != null) {
    //     // will query user on login/ sign-up
    //   } else {
    //     // Nullify the user if not authenticated
    //   }
    // });
  }

  void _updateStream() {
    //
  }

  @override
  void dispose() {
    removeListener(_updateStream);
    super.dispose();
  }
}