import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/profile/profile_builder.dart';
import 'package:paw_pals/widgets/bars/our_app_bar_profile.dart';


/// A screen that displays either the user's own profile and other profiles
/// depending on if the profile uid matches the uid of the current user.
class ProfileScreen extends StatelessWidget {
  final String? uid;

  const ProfileScreen({
    super.key,
    this.uid
  });

  @override
  Widget build(BuildContext context) {

    if (uid == null) {
      return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (FirebaseAuth.instance.currentUser?.uid != null) {
              return Scaffold(
                appBar: OurAppBarProfile.build("My Profile", context),
                body: ProfileBuilder(uid: FirebaseAuth.instance.currentUser!.uid),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ProfileBuilder(uid: uid!),
    );
  }
}