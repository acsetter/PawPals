import 'package:flutter/material.dart';

import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/list_of_posts.dart';

/// Wraps the gridview in a widget that manages data and user refresh.
class LikedPostBuilder extends StatefulWidget {
  /// The [UserModel] of the user who's liked posts to show.
  final UserModel userModel;

  const LikedPostBuilder({super.key, required this.userModel});

  @override
  State<LikedPostBuilder> createState() => _LikedPostBuilderState();
}

class _LikedPostBuilderState extends State<LikedPostBuilder> {
  UserModel get userModel => super.widget.userModel;
  late Future<List<PostModel>?> likedPostsFuture;

  @override
  void initState() {
    likedPostsFuture = FirestoreService.likedPostsByUser(userModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          FutureBuilder(
            future: likedPostsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListGrid(posts: snapshot.data!);
              }

              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())
              );
            },
          ),
        ],
      ),
    );
  }

  /// Called on user pull down to refresh the screen and data.
  Future<void> refresh() async {
    List<PostModel>? likedPosts = await FirestoreService.likedPostsByUser(userModel);
    setState(() {
      likedPostsFuture = Future.value(likedPosts);
    });
  }
}