import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../controllers/app_user.dart';
import '../models/post_model.dart';
import 'Post/DetailedPost.dart';

/// Builds a Gridview that will return MyCardForDisplay.
///
/// A list of posts from the post model is pumped into this widget
/// in order to build a grid style list of posts.
class ListGrid extends StatelessWidget {
  final List<PostModel> post;

  const ListGrid({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: post.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return MyCardForDisplay(post[index]);

        },



      );
  }
}

/// MyCardForDisplay will display the cards that occur within the gridview
/// with an image of the corresponding pet and the ability to go to the
/// detailed post screen when clicked on.
///
/// If the user is on their own profile, they are able to long press
/// on a card to delete the post.
/// The user is not allowed to delete posts from other user's profiles.
class MyCardForDisplay extends StatelessWidget {
  const MyCardForDisplay(this.post, {super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailedPost(post: post)));
          },
      // Long press on a card, if the post id of the card matches with the instance of the current user logged in
      onLongPress: () {
        if (post.uid == AppUser.instance.userModel!.uid) {
          showModalBottomSheet<void>(context: context,
              builder: (BuildContext context) {
                return Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Delete'),
                        // The user may delete a post that they have created
                        onTap: () {
                          FirestoreService.deletePosts(post);
                        },
                      ),
                    ]
                );
              }
          );
        }
      },
          // Builds the card that is displayed within each tile of the grid
          child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160, imageUrl: post.petPhotoUrl!,
                  )
                  ],
                ),
              )
          )
      );
  }
}



