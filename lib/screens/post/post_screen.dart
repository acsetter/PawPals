import 'package:flutter/material.dart';

import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/Post/detailed_post.dart';

/// A screen that displays a Post via a given [PostModel].
class PostScreen extends StatelessWidget {
  final PostModel post;

  const PostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post")),
      body: DetailedPost(post: post),
    );
  }
}