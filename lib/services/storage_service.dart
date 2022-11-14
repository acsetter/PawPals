// ignore_for_file: invalid_return_type_for_catch_error
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paw_pals/utils/app_log.dart';

/// A class for managing, storing, and fetching files using [FirebaseStorage].
/// <br /><br />
/// **Storage Structure:**
/// ```
/// (root)
/// |-- users/
/// |    |-- (UID)    --> profile pic
/// |-- posts/
///      |-- (PostId) --> post pic
/// ```
/// <br />
/// **Helpful links:**
/// * <a href="https://firebase.google.com/docs/storage/flutter/start?hl=en"> FirebaseStorage Docs </a>
/// * <a href="https://stackoverflow.com/questions/51857796/flutter-upload-image-to-firebase-storage">How to Upload Image to Firebase Storage</a>
/// * <a href="https://pub.dev/packages/image_picker">Image Picker Package</a>
/// * <a href="https://stackoverflow.com/questions/70413319/failed-to-load-network-image-in-flutter-web">Failed to load network image in flutter web</a>
class StorageService {
  static final List<String> validExts = ['jpg', 'png'];
  
  StorageService._();

  /// Shortened reference to the [FirebaseStorage] instance
  static final FirebaseStorage _store = FirebaseStorage.instance;

  /// Shortened reference to the uid of the logged-in user.
  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// references the root of the storage directory ('/').
  static final Reference _rootRef = _store.ref();

  /// references the users folder in storage ("/users/").
  static final Reference _usersRef = _rootRef.child('users');

  /// references the users folder in storage ("/posts/").
  static final Reference _postRef = _rootRef.child('posts');

  /// Uploads an expected file as the logged-in user's profile image and
  /// returns a download url upon successful storage of the image in the cloud.
  static Future<String?> uploadProfileImage(File file) async {
    String ext = file.path.split('.').last;
    // ensure the uploaded file is a supported image
    if (!validExts.contains(ext)) {
      Logger.log("File of extension type '$ext' is not supported", isError: true);
      return null;
    }

    return await _usersRef.child(_uid!).putFile(file)
      .then((snapshot) {
        Logger.log("StorageService: uploaded ${snapshot.ref.name}");
        return snapshot.ref.getDownloadURL()
          .then((url) {
            Logger.log("StorageService: retrieved url for ${snapshot.ref.name}");
            return url;
          }, onError: (e) => Logger.log(e.toString(), isError: true));
      }, onError: (e) => Logger.log(e.toString(), isError: true)
    );
  }

  /// Uploads an expected file for a newly created post and returns a
  /// download url upon successful storage of the image in the cloud.
  static Future<String?> uploadPostImage(File file, String postId) async {
    String ext = file.path.split('.').last;
    if (!validExts.contains(ext)) {
      Logger.log("File of extension type '$ext' is not supported", isError: true);
      return null;
    }

    return await _postRef.child(postId).putFile(file)
      .then((snapshot) {
        Logger.log("StorageService: uploaded ${snapshot.ref.name}");
        return snapshot.ref.getDownloadURL()
          .then((url) {
            Logger.log("StorageService: retrieved url for ${snapshot.ref.name}");
            return url;
          }, onError: (e) => Logger.log(e.toString(), isError: true));
      }, onError: (e) => Logger.log(e.toString(), isError: true));
  }

  /// Uses [ImagePicker] to load file from expected [ImageSource] and
  /// returns a [File] on future complete.
  static Future<File?> pickImageFrom(ImageSource source) async {
    XFile? src = await ImagePicker().pickImage(source: source, maxWidth: 1080,
        maxHeight: 1080, imageQuality: 50);

    return src != null ? File(src.path) : null;
  }
}