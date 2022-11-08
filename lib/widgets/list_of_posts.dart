import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';



class DummyGrid extends StatelessWidget {
  const DummyGrid(this.post, {super.key});

  final List<PostModel> post;

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



          //return Text(paintings[index].title);
        },

      );
  }
}


class MyCardForDisplay extends StatelessWidget {
  const MyCardForDisplay(this.post, {super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    // to make the card interactive have to put the card inside a gesture detector
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
                    Image.asset(post.petPhotoUrl!),
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

    // we had two entry points to the detail screen but only one passed in
    // information. This determined if inforation was passed in and if so
    // show it
    if (post == null) {
      contentToShow = Text("No posts yet");
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
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Go Back"))
          ],
        ),
      ),
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