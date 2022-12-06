import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:paw_pals/Blocks/swipe_block.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/widgets/screencards.dart';
import 'package:paw_pals/utils/app_log.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/bars/our_app_bar_pref.dart';

class FeedScreen extends StatefulWidget {

  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedScreen get parent => super.widget;

  final String screenTitle = "Feed";

  Future<List<PostModel>> fetchPosts() async {
    List<PostModel> posts = await FirestoreService.getPreferences()
        .then((prefModel) => FirestoreService.getFeedPosts(prefModel)) ?? AppData.post;
    posts.add(AppData.post[0]);
    posts.add(AppData.post[1]);
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var likedPosts = await FirestoreService.getUser()
        .then((userModel) => userModel?.likedPosts);

    List<PostModel> returnedPosts = [];

    for (PostModel post in posts) {
      if (post.uid != uid && !likedPosts!.any((pid) => pid == post.postId)) {
        returnedPosts.add(post);
      }
    }

    returnedPosts.add(AppData.post[0]);
    returnedPosts.add(AppData.post[1]);

    return returnedPosts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => SwipeBlock()..add(LoadPosts(posts: snapshot.data!))
              )
            ],
            child: StreamBuilder(
                stream: FirestoreService.prefModelStream,
                builder: (context, snapshot) => Scaffold(
                  appBar: OurAppBarPref.build(screenTitle, context),
                  body: BlocBuilder<SwipeBlock, SwipeState>(
                      builder: (context, state) {
                        if(state is SwipeLoading){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else if (state is SwipeLoaded){
                          return Column(
                            children: [
                              Draggable(
                                key: const Key("draggablewidget"),
                                feedback: ScreenCards(post: state.posts[0]),
                                childWhenDragging: ScreenCards(post: state.posts[1]),
                                onDragEnd: (drag) {
                                  if(state.posts.length == 2){
                                    showFloatingEndSnackBar(context);
                                  }
                                  // ignore: unnecessary_null_comparison
                                  else if(state.posts[2] == null && state.posts.length > 2) {
                                    context.read<SwipeBlock>()
                                      .add(SwipeLeft(post: state.posts[-1]));
                                  }
                                  if (drag.velocity.pixelsPerSecond.dx < -200 && state.posts.length > 2 ) {
                                    showFloatingLeftSnackBar(context);
                                    context.read<SwipeBlock>()
                                        .add(SwipeLeft(post: state.posts[0]));
                                  } else if (drag.velocity.pixelsPerSecond.dx > 200 && state.posts.length > 2) {
                                    AppUser.instance.likePost(state.posts[0].postId.toString());
                                    showFloatingRightSnackBar(context);
                                    context.read<SwipeBlock>()
                                      .add(SwipeRight(post: state.posts[0]));
                                  } else if (drag.velocity.pixelsPerSecond.dx < 200 && drag.velocity.pixelsPerSecond.dx > -200) {
                                    Logger.log('Stay');
                                  } else {
                                    Logger.log('Stay');
                                  }
                                },
                                child: ScreenCards(post: state.posts[0]),
                              )
                            ],
                          );
                        } else {
                          return const Text('Something Went Wrong');
                        }
                      }
                  ),
                )
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showFloatingRightSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: const <Widget>[
        Icon(Icons.favorite_outline),
        Text("    Like!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
      ]
    ),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 1),
    shape: const StadiumBorder(),
    action: SnackBarAction(
      label: "Go To Liked Posts!",
      textColor: Colors.yellowAccent,
      onPressed: () {
        Get.to(() => const LikedPostScreen());
      },
    ),
  ),
  );
}

  void showFloatingLeftSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    const snackBar = SnackBar(
      content: Text(
        "Dislike",
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.pinkAccent,
      duration: Duration(milliseconds: 300),
      shape: StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFloatingEndSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    const snackBar = SnackBar(
      content: Text(
        "Out of Posts!",
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.blue,
      duration: Duration(milliseconds: 300),
      shape: StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}