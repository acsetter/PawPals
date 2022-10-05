import 'package:firebase_auth/firebase_auth.dart';

import '../utils/app_log.dart';

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
  /// password.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **email-already-in-use**:
  ///  - Thrown if there already exists an account with the given email address.
  /// - **invalid-email**:
  ///  - Thrown if the email address is not valid.
  /// - **operation-not-allowed**:
  ///  - Thrown if email/password accounts are not enabled. Enable
  ///    email/password accounts in the Firebase Console, under the Auth tab.
  /// - **weak-password**:
  ///  - Thrown if the password is not strong enough.
  static Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Logger.log('Signed up in as: ${_user?.email ?? "error getting email"}');
      return "";
    } on FirebaseAuthException catch (e) {
      Logger.log('${e.code}: ${e.message}', isError: true);
      switch (e.code) {
        case "email-already-in-use":
        case "invalid-email":
        case "weak-password":
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