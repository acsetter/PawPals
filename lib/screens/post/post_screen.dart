import 'package:flutter/material.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/Post/DetailedPost.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class PostScreen extends StatelessWidget {
  final String screenTitle = "Post";
  final PostModel post;

  const PostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: OurAppBar.build(screenTitle),
        // The main body of the Screen:
        body:
             DetailedPost(post:post),
            );
  }
}