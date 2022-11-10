import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw_pals/Blocks/swipe_block.dart';
import 'package:paw_pals/widgets/screencards.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/utils/app_log.dart';

import '../../widgets/bars/our_app_bar_pref.dart';


class FeedScreen extends StatelessWidget {
  final String screenTitle = "Feed Screen";

  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBarPref.build(screenTitle, context),
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
                      showDialog(context: context,
                          builder: (context) => AlertDialog(
                            title: Text('${state.posts[0].petName}'),
                            content: Text('${state.posts[0].postDescription}'),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)
                              ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(Colors.white),
                                    backgroundColor: MaterialStateProperty.all(Colors.red),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(20)
                                      )
                                      ),

                                    ),
                                  child: const Text('Go\nBack'),
                                  ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.purpleAccent),
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                  ),

                                ),
                                child: const Text('See\nProfile'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.read<SwipeBlock>().add(
                                      SwipeRight(post: state.posts[0]));
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(Colors.green),

                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20),
                                  )
                                ),
                              ),
                                child: const Text('To\nLiked Posts!'),


                              )],
                          ));
                        ;
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