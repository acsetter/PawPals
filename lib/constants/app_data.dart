import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import 'app_types.dart';

/// Static data for use in test and development
class AppData {
  const AppData._();

  static AssetImage get corgi => const AssetImage('assets/images/corgi.jpg');
  static AssetImage get englishBulldog => const AssetImage('assets/images/english_bulldog.jpg');
  static AssetImage get siameseCat => const AssetImage('assets/images/siamese_cat.jpg');
  static AssetImage get tabbyCat => const AssetImage('assets/images/tabby_cat.jpg');
  static AssetImage get profileMan => const AssetImage('assets/images/profile_man.jpg');
  static AssetImage get profileWoman => const AssetImage('assets/images/profile_woman.jpg');

  static UserModel get fakeManUser => UserModel(
    uid: '_fakeMan',
    email: 'joe@is.fake',
    first: 'Joseph',
    last: 'Smith',
    username: 'j_smith20',
    photoUrl: '',
  );

  static UserModel get fakeWomanUser => UserModel(
    uid: '_fakeWoman',
    email: 'janet@is.fake',
    first: 'Janet',
    last: 'Palmer',
    username: 'cat_lady',
    photoUrl: '',
  );
  static PostModel get fakePost => PostModel(
    postId: '11111',
    uid: '22222',
    timestamp: '_',
    postDescription: '_',
    longitude: 400.0,
    latitude: 200.00,
    geoHash: '_',
    petName: 'Whiskers',
    petAge: 3,
    petGender: PetGender.male,
    petPhotoUrl: 'assets/images/siamese_cat.jpg',
    isKidFriendly: true,
    isPetFriendly: true,
  );

  // Feel free to generate fake post data here
}