import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
///
///



class ScreenCards extends StatelessWidget {
  final color;

  //final String buttonLabelLeft = "left swipe (For Later)";
  //final String buttonLabelRight = "right swipe (For Later)";


  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const ScreenCards({Key? key, this.color}) : super(key:key);

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right:20
        ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height /1.6,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
        )

      ],
    )
    )
    );
  }
}
