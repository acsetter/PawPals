import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw_pals/Blocks/swipe_block.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/empty_screen_card.dart';
import 'package:paw_pals/widgets/screencards.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/utils/app_log.dart';
import 'package:paw_pals/models/post_model.dart';


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
                  child: ScreenCards(post: state.posts[0]),
                  feedback: ScreenCards(post: state.posts[0]),
                  childWhenDragging: ScreenCards(post: state.posts[1]),
                  onDragEnd: (drag){
                    if (drag.velocity.pixelsPerSecond.dx < 0){
                    context.read<SwipeBlock>()
                    .add(SwipeLeft(post: state.posts[0]));
                    Logger.log("Swiped left");
                    } else if (drag.velocity.pixelsPerSecond.dx >0 ) {
                      context.read<SwipeBlock>()
                        .add(SwipeRight(post: state.posts[0]));
                      Logger.log('Swiped right');
                    } else  {

                      Logger.log('Stay');
                    }
                  },
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