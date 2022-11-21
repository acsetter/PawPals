import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../controllers/app_user.dart';
import '../models/post_model.dart';
import 'Post/DetailedPost.dart';

/// Lists of Posts: creates Gridview that will return MyCardForDisplay.
/// This widget is utilized on the user's profile and liked posts.
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
      onLongPress: () {
        if (post.uid == AppUser.instance.userModel!.uid) {
          showModalBottomSheet<void>(context: context,
              builder: (BuildContext context) {
                return Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Delete'),
                        onTap: () {
                          FirestoreService.deletePost(post);
                        },
                      ),
                    ]
                );
              }
          );
        }
      },
          child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160, imageUrl: post.petPhotoUrl!,
                    //Image.asset(post.petPhotoUrl!, fit: BoxFit.fill),
                  )
                  ],
                ),
              )
          )
      );
  }
}


/// This detailed screen is temporary, it will be replaced by the
/// detailed screen that Savannah has created.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.post});

  final PostModel? post;

  @override
  Widget build(BuildContext context) {

    Widget contentToShow =
    CachedNetworkImage(
        imageUrl: post!.petPhotoUrl!,
        fit: BoxFit.cover,
        width: 160,
        height: 160);

    if (post == null) {
      contentToShow = const Text("No posts yet");
    }
    else {
      contentToShow;
      //Image.asset(post!.petPhotoUrl!);
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed Post"),
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(),
            contentToShow,
            const Divider(),
            Column(
              children: [
                Text(post!.petName!,
                    style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                     ),
              ],
            ),
              Column(
                children: [
                  Text("Pet Age: ${post!.petAge}"),
                  Text("Pet Gender: ${post!.petGender?.name}"),
                  Text("Pet Type: ${post!.petType?.name}"),
                ],
              ),
            Flexible(child: Text("Post Description: ${post!.postDescription}"),)
      ]
          ),
      )
    );
  }
}


