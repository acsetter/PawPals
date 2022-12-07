import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';

import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/Post/detailed_post.dart';
import 'package:paw_pals/constants/app_types.dart';

import '../screens/post/liked_post_screen.dart';


/// Builds a Gridview that will return MyCardForDisplay.
///
/// A list of posts from the post model is pumped into this widget
/// in order to build a grid style list of posts.
class ListGrid extends StatelessWidget {
  final List<PostModel> posts;

  const ListGrid({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int i) {
          return MyCardForDisplay(posts[i]);
        },
        childCount: posts.length,
      ),
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailedPost(post: post)));
      },
      // Long press on a card, if the post id of the card matches with the instance of the current user logged in
      onLongPress: () {
        if (post.uid == AppUser.instance.userModel!.uid) {
            showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
              return Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete'),
                    // The user may delete a post that they have created
                    onTap: () {
                      FirestoreService.deletePosts(post);
                      Get.offAll(const ProfileScreen());
                    },
                  ),
                ]
              );
            }
          );
        }
        else{
          showModalBottomSheet<void>(context: context,
              builder: (BuildContext context) {
                return Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.cancel),
                        title: const Text('Unlike'),
                        // The user may delete a post that they have created
                        onTap: () {
                          AppUser.instance.unlikePost(post.postId!);
                          Get.offAll(const LikedPostScreen());
                        },
                      ),
                    ]
                );
              }
          );

        }
      }, // Builds the card that is displayed within each tile of the grid
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: 160,
                height: 160,
                imageUrl: post.petPhotoUrl!,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 3),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        post.petGender == PetGender.female ? Icons.female : Icons.male,
                        color: Colors.white,
                        size: 16,
                        shadows: const [
                          Shadow(
                              blurRadius: 16.0,
                              color: Color.fromARGB(150, 0, 0, 0)
                          )
                        ],
                      ),
                    ),
                    Text(
                      "${post.petName ?? 'Name Unavailable'}, ${post.petAge}",
                      style: const TextStyle(
                        fontFamily: "Proxima-Nova-Bold",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        shadows: <Shadow>[
                          Shadow(
                              blurRadius: 16.0,
                              color: Color.fromARGB(150, 0, 0, 0)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}



