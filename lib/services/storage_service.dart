// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/utils/app_log.dart';

/// A class for storing and fetching files using [FirebaseStorage].
/// <br /><br />
/// **Storage Structure:**
/// ```
/// (root)
/// |-- users/
/// |    |-- (UID)/
/// |         |-- (UID).(png/jpg)    --> profile pic
/// |-- posts/
///      |-- (PostID)/
///           |-- (PostId).(png/jpg) --> post pic
/// ```
/// <br />
/// **Helpful links:**
/// * <a href="https://firebase.google.com/docs/storage/flutter/start?hl=en"> FirebaseStorage Docs </a>
/// * <a href="https://stackoverflow.com/questions/51857796/flutter-upload-image-to-firebase-storage">How to Upload Image to Firebase Storage</a>
/// * <a href="https://pub.dev/packages/image_picker">Image Picker Package</a>
class StorageService {
  static final FirebaseStorage _store = FirebaseStorage.instance;

  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// references the root of the storage directory ('/').
  static final Reference _rootRef = _store.ref();

  /// references the users folder in storage ("/users/").
  static final Reference _usersRef = _store.ref().child('users');

  /// references the users folder in storage ("/posts/").
  static final Reference _postRef = _store.ref().child('posts');

  static Future<String?> getProfileImgUrl(UserModel userModel) async {
    // Path structure: '/u/<UID>/<UID.jpg>'
    return await _usersRef.child(userModel.uid!).child(userModel.photoUrl!)
        .getDownloadURL()
        .catchError((e) => Logger.log(e.toString(), isError: true));
  }

  static Future<String?> getPhotoURL() async {
    return await _usersRef.child(_uid!).child("profile.png").getDownloadURL();
  }

  static Future<Uint8List?> getPhotoBytes() async {
    return await _usersRef.child(_uid!).child("profile.png").getData();
  }

  // static Future<String?> uploadProfileImg(Image image) async {
  //   if (_uid == null) {
  //     Logger.noUserError();
  //     return null;
  //   }
  //
  //   ByteData? byteData = await image.toByteData();
  //
  //   if (byteData != null) {
  //     Uint8List data = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  //     await _usersRef.child(_uid!).putData(data);
  //
  //     return await _usersRef.child(_uid!).getDownloadURL();
  //   }
  // }

  // TODO: Construct methods for uploading and downloading images.
}