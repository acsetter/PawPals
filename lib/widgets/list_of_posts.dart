import 'package:flutter/material.dart';
import '../models/post_model.dart';


class ListGrid extends StatelessWidget {
  final List<PostModel> post;

  const ListGrid({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: post.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return MyCardForDisplay(post[index]);

        },

      );
  }
}


class MyCardForDisplay extends StatelessWidget {
  const MyCardForDisplay(this.post, {super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(post: post),));
          },
          child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Text(post.petName!)
                    //Image.asset(post.petPhotoUrl!, fit: BoxFit.fill),
                  ],
                ),
              )));
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.post});

  final PostModel? post;

  @override
  Widget build(BuildContext context) {

    Widget contentToShow;

    if (post == null) {
      contentToShow = const Text("No posts yet");
    }
    else {
      contentToShow = const Text("Photo display not yet implemented");
      //Image.asset(post!.petPhotoUrl!);
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed Post"),
      ),
      body: Center(
        child: Column(
          children: [
            contentToShow,
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
                ],
              ),
              Text("Post Description: ${post!.postDescription}"),
      ]
          ),
      )
    );
  }
}


