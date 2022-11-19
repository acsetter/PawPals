import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/profile/profile_builder.dart';

import '../../widgets/bars/our_app_bar_profile.dart';

class ProfileScreen extends StatelessWidget {
  final String? uid;
  const ProfileScreen({
    super.key,
    this.uid
  });

  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      appBar: OurAppBarProfile.build("My Profile", context),
      body: uid == null ? 
      StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfileBuilder(uid: uid ?? snapshot.data!.uid);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ) : ProfileBuilder(uid: uid!),
    );
  }
}
