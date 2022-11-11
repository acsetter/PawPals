import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
                    Image.asset(post.petPhotoUrl!, fit: BoxFit.fill),
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
      contentToShow = Image.asset(post!.petPhotoUrl!);
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed Post"),
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
                  Text("Pet Gender: ${post!.petGender}"),
                ],
              ),
              Text("Post Description: ${post!.postDescription}"),
      ]
          ),
      )
    );
  }
}

/*
class ListOfPosts extends StatefulWidget {
  final PostModel post;

  const ListOfPosts({ Key? key, required this.post,}) : super(key: key);

  Widget build(BuildContext context) {
    return FutureBuilder<List<Posts>>(
      future: getPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              alignment: FractionalOffset.center,
              padding: const EdgeInsets.only(top: 10.0),
              child: const CircularProgressIndicator());
        } else if (view == "grid") {
          // build the grid
          return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
//                    padding: const EdgeInsets.all(0.5),
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data.map((PostModel post) {
                return GridTile(child: PostTile(post));
              }).toList());
        } else if (view == "feed") {
          return Column(
              children: snapshot.data.map((PostModel post) {
                return post;
              }).toList());
        }
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class PostTile extends StatelessWidget {
  final PostTile imagePost;

  PostTile(this.imagePost);

  clickedImage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return Center(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Photo',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: imagePost,
                ),
              ],
            )),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

 */