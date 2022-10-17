import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/constants/app_data.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
///
///



class ScreenCards extends StatelessWidget {
  final color;

  ScreenCards({Key? key, this.color}) : super(key:key);
  //final String buttonLabelLeft = "left swipe (For Later)";
  //final String buttonLabelRight = "right swipe (For Later)";


  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.


  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right:30,
        ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height /1.45,
        width: MediaQuery.of(context).size.width /1.2,
        child: Stack(
          children: [

            Container(
              decoration: BoxDecoration(

                color: color,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AppData.tabbyCat,),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(1.0),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(3,3),
                  )
                ]
              ),
        ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(185, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              ),
            ),
            Positioned(
              bottom:30,
              left: 15,
              child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bubbles, 7',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  )
                ),
                Text(
                    'In search of a loving home!',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )
                ),
                Row(
                  children: [
                    Container(
                      height:40,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AppData.tabbyCat,
                        )
                      ),
                    )

                  ]
                )
              ],
            )
            )
      ],
    )
    )
    );
  }
}
