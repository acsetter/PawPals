import 'package:flutter/material.dart';

import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/widgets/Post/liked_post_builder.dart';
import 'package:paw_pals/models/user_model.dart';

/// The screen that displays the logged-in user's list of liked posts.
class LikedPostScreen extends StatelessWidget {
  const LikedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liked Posts")),
      // get the UserModel of the logged-in user via AppUser singleton
      body: StreamBuilder<UserModel?>(
        stream: AppUser.instance.appUserChanges(),
        builder: (context, snapshot) {
          if (AppUser.instance.userModel != null) {
            return LikedPostBuilder(userModel: AppUser.instance.userModel!);
          }
          // show loading indicator if UserModel is null.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}