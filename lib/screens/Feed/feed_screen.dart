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
                  onDragEnd: (drag){
                    if(state.posts.length == 2){

                      Logger.log("end of list");
                    }
                    // ignore: unnecessary_null_comparison
                    else if(state.posts[2] == null && state.posts.length > 2){

                      context.read<SwipeBlock>()
                          .add(SwipeLeft(post: state.posts[-1]));
                    }
                    if (drag.velocity.pixelsPerSecond.dx < 0 && state.posts.length > 2 ){
                      Logger.log("Swiped left" );

                      context.read<SwipeBlock>()
                          .add(SwipeLeft(post: state.posts[0]));
                    }
                    else if (drag.velocity.pixelsPerSecond.dx >0 && state.posts.length > 2) {
                      Logger.log('Swiped right');

                        context.read<SwipeBlock>()
                        .add(SwipeRight(post: state.posts[0]));
                    } else  {
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
}