import 'package:flutter/material.dart';

import '../models/user_model.dart';

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

  // Feel free to generate fake post data here
}