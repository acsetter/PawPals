// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/screens/home_screen.dart';

/// Directs user to login-screen or home-screen depending on auth status.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) { // means the user is not null (logged in)
          return const HomeScreen();
        }

        return LoginScreen(); // show login for null user (not logged in)
      }
    );
  }
}