import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/constants/app_types.dart';

/// Static data for use in test and development
class AppData {
  const AppData._();

  static AssetImage get logo => const AssetImage('assets/images/logo.png');

  static AssetImage get corgi => const AssetImage('assets/images/corgi.jpg');
  static AssetImage get englishBulldog => const AssetImage('assets/images/english_bulldog.jpg');
  static AssetImage get siameseCat => const AssetImage('assets/images/siamese_cat.jpg');
  static AssetImage get tabbyCat => const AssetImage('assets/images/tabby_cat.jpg');
  static AssetImage get profileMan => const AssetImage('assets/images/profile_man.jpg');
  static AssetImage get profileWoman => const AssetImage('assets/images/profile_woman.jpg');
  static AssetImage get emptyCage => const AssetImage('assets/images/empty_cage.jpg');
  static AssetImage get dogCage => const AssetImage('assets/images/dogcreate.jpg');

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

  static List<PostModel> post = [
    PostModel(
      postId: "1",
      uid: "1",
      postDescription: "Bob is an adventurous Cat!",
      petName: "Bob",
      petAge: 7,
      petGender: PetGender.male,
      petPhotoUrl: 'assets/images/tabby_cat.jpg',
    ),
    PostModel(
      postId: "2",
      uid: "2",
      postDescription: "Carl likes to sleep and chew on bones!",
      petName: "Carl",
      petAge: 5,
      petGender: PetGender.female,
      petPhotoUrl: 'assets/images/corgi.jpg',
    ),
    PostModel(
      postId: "3",
      uid: "3",
      postDescription: "Doug likes alot of treats!",
      petName: "Doug",
      petAge: 4,
      petGender: PetGender.female,
      petPhotoUrl: 'assets/images/english_bulldog.jpg',
    ),
    PostModel(
      postId: "4",
      uid: "4",
      postDescription: "Earl is Lazy!",
      petName: "Earl",
      petAge: 9,
      petGender: PetGender.male,
      petPhotoUrl: 'assets/images/siamese_cat.jpg',
    ),
    PostModel(
      postId: "5",
      uid: "5",
      postDescription: "Please update your preferences to\nSee more pets!",
      petName: "You're Out of Pets!",
      petAge: 0,
      petPhotoUrl: 'assets/images/profile_man.jpg',
    ),
    PostModel(
      postId: "6",
      uid: "6",
      postDescription: "end of list",
      petName: "null",
      petAge: 0,
      petPhotoUrl: 'assets/images/profile_man.jpg',
    ),
  ];

  // Feel free to generate fake post data here
}