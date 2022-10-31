import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw_pals/Blocks/swipe_block.dart';
import 'package:paw_pals/widgets/screencards.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/utils/app_log.dart';

class FeedScreen extends StatelessWidget {
  final String screenTitle = "Feed Screen";

  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build(screenTitle),
        body: BlocBuilder<SwipeBlock, SwipeState>(
          builder: (context, state) {
            if(state is SwipeLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is SwipeLoaded){
              return Column(children: [
                Draggable(
                  feedback: ScreenCards(post: state.posts[0]),
                  childWhenDragging: ScreenCards(post: state.posts[1]),
                  onDragEnd: (drag) {
                    if(state.posts.length == 2){
                      showFloatingEndSnackBar(context);

                    }
                    // ignore: unnecessary_null_comparison
                    else if(state.posts[2] == null && state.posts.length > 2){
                      context.read<SwipeBlock>()
                          .add(SwipeLeft(post: state.posts[-1]));
                    }
                    if (drag.velocity.pixelsPerSecond.dx < -500 && state.posts.length > 2 ){
                      showFloatingLeftSnackBar(context);
                      context.read<SwipeBlock>()
                          .add(SwipeLeft(post: state.posts[0]));
                    }
                    else if (drag.velocity.pixelsPerSecond.dx > 500 && state.posts.length > 2) {
                      showFloatingRightSnackBar(context);
                        context.read<SwipeBlock>()
                        .add(SwipeRight(post: state.posts[0]));
                    } else {
                        Logger.log('Stay');
                    }
                  },
                  child: ScreenCards(post: state.posts[0]),
                )
              ],
              );
            }
            else { return const Text('Something Went Wrong');
          }
        }
      ),
    );
  }
  void showFloatingRightSnackBar(BuildContext context){
    const snackBar = SnackBar(
      content: Text(
        "Like",
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.greenAccent,
      duration: Duration(milliseconds: 300),
      shape: StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFloatingLeftSnackBar(BuildContext context){
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