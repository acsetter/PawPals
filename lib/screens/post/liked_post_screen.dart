import 'package:flutter/material.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class LikedPostScreen extends StatelessWidget {
  const LikedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build("Liked Posts"),
      body: StreamBuilder<List<PostModel>?>(
        stream: AppUser.instance.likedPostsStream(),
        builder: (BuildContext context, snapshot) {
          List<PostModel> postModels = AppUser.instance.likedPosts ?? [];

          // TODO: Feed postModel List to post list widget.

          String postStr = "Liked Posts: \n";
          for (PostModel post in postModels) {
            postStr = "$postStr\n$post";
          }

          return Text(postStr);
        },
      ),
    );
  }
}