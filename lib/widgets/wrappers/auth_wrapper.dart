// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Directs user to login-screen or home-screen depending on auth status.
class AuthWrapper extends StatelessWidget {
  final Widget login;
  final Widget home;

  const AuthWrapper({super.key, required this.home, required this.login});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) { // means the user is not null (logged in)
          return home;
        }

        return login; // show login for null user (not logged in)
      }
    );
  }
}