import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Draggable(
            child: ScreenCards(post: PostModel.post[0]),
            feedback: ScreenCards(post: PostModel.post[0]),
            childWhenDragging: ScreenCards(post: PostModel.post[1]),
            onDragEnd: (drag){
              if (drag.velocity.pixelsPerSecond.dx < 500 &&
                  drag.velocity.pixelsPerSecond.dx > -500){
                Logger.log("Stay");
              } else if (drag.velocity.pixelsPerSecond.dx >500 ) {
                Logger.log('Swiped right');
              } else  {
                Logger.log('Swiped left');
              }
            },
          )
        ]
      )
    );


  }
}