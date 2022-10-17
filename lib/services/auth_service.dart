import 'package:firebase_auth/firebase_auth.dart';

import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/utils/app_log.dart';

/// A service class to manage Firebase auth and handle auth errors.
class AuthService {
  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static User? get _user => _auth.currentUser;

  /// Signs a user out of the app. If successful, it also updates any
  /// authStateChanges, idTokenChanges or userChanges stream listeners.
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Attempts to sign in a user with the given email address and password.
  /// If successful, it also signs the user in into the app and updates any
  /// authStateChanges, idTokenChanges or userChanges stream listeners.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///  - Thrown if the email address is not valid.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the given email.
  /// - **wrong-password**:
  ///  - Thrown if the password is invalid for the given email, or the account
  ///    corresponding to the email does not have a password set.
  static Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Logger.log('Logged in as: ${FirebaseAuth.instance.currentUser?.email ?? "error getting email"}');
      return "";
    } on FirebaseAuthException catch (e) {
      Logger.log('${e.code}: ${e.message}', isError: true);
      switch (e.code) {
        case "invalid-email":
        case "user-not-found":
        case "wrong-password":
          return "invalid-email-or-password";
        case "operation-not-allowed":
        case "user-disabled":
        default:
          return "unhandled-error";
      }
    }
  }

  /// Tries to create a new user account with the given email address and
  /// password. Returns an empty String if successful or an error-message code.
  ///
  /// Error codes: <br/>
  /// > **email-already-in-use**: There already exists an account with the
  /// given email address.
  ///
  /// > **invalid-email**: The email address is not valid.
  ///
  /// > **unhandled-error**: An error occurred that no corresponding code has
  /// been made for.
  ///
  /// > **username-taken**: Username is taken by another account and cannot be
  /// claimed on sign up.
  ///
  /// > **weak-password**: The password is not strong enough.
  static Future<String> signUp({
    required String email, 
    required String password, 
    required String username, 
    String? first, 
    String? last}) async {
    try {
      bool? isUnameUnique = await FirestoreService.isUsernameUnique(username);
      // ^ returns null if an error occurred when querying database
      if (isUnameUnique == null) return "unhandled-error";
      if (!isUnameUnique) return "username-taken";

      await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((res) async {
          FirestoreService.createUser(
            UserModel(
              uid: res.user?.uid,
              email: email,
              username: username,
              first: first,
              last: last,
            )
          );
        });
      Logger.log("Auth entry created for ${_user?.email}");
      return "";
    } on FirebaseAuthException catch (e) {
      Logger.log('${e.code}: ${e.message}', isError: true);
      switch (e.code) {
        case "email-already-in-use":
        case "invalid-email":
        case "weak-password":
          // Code is the same as the error message key for translation
          return e.code;
        case "operation-not-allowed":
        default:
          return "unhandled-error";
      }
    }
  }

  /// Sends a password reset email to the given email address.
  ///
  /// To complete the password reset, call [verifyCode] with the code
  /// supplied in the email sent to the user, along with the new password
  /// specified by the user.
  ///
  /// May throw a [FirebaseAuthException] with the following error codes:
  ///
  /// - **auth/invalid-email**
  ///   Thrown if the email address is not valid.
  /// - **auth/missing-android-pkg-name**
  ///   An Android package name must be provided if the Android app is required
  ///   to be installed.
  /// - **auth/missing-continue-uri**
  ///   A continue URL must be provided in the request.
  /// - **auth/missing-ios-bundle-id**
  ///   An iOS Bundle ID must be provided if an App Store ID is provided.
  /// - **auth/invalid-continue-uri**
  ///   The continue URL provided in the request is invalid.
  /// - **auth/unauthorized-continue-uri**
  ///   The domain of the continue URL is not whitelisted. Whitelist the domain
  ///   in the Firebase console.
  /// - **auth/user-not-found**
  ///   Thrown if there is no user corresponding to the email address.
  static Future<String> sendCode({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "code-sent";
    } on FirebaseAuthException catch (e) {
      Logger.log('${e.code}: ${e.message}', isError: true);
      switch (e.code) {
        case "invalid-email":
          return e.code;
        case "user-not-found":
          return "code-sent"; // Don't give error for security reasons
        case "operation-not-allowed":
        default:
          return "unhandled-error";
      }
    }
  }

  /// Checks a password reset code sent to the user by email or other
  /// out-of-band mechanism.
  ///
  /// Returns the user's email address if valid.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **expired-action-code**:
  ///  - Thrown if the password reset code has expired.
  /// - **invalid-action-code**:
  ///  - Thrown if the password reset code is invalid. This can happen if the
  ///    code is malformed or has already been used.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the password reset code.
  ///    This may have happened if the user was deleted between when the code
  ///    was issued and when this method was called.
  static Future<String> verifyCode({required String code}) async {
    try {
      await _auth.verifyPasswordResetCode(code);
      return 'code verified';
    } on FirebaseAuthException catch (e) {
      Logger.log('${e.code}: ${e.message}', isError: true);
      switch (e.code) {
        case "expired-action-code":
        case "invalid-action-code":
          return e.code;
        case "operation-not-allowed":
        case "user-disabled":
        default:
          return "unhandled-error";
      }
    }
  }
}