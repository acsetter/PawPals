import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';

class ScreenCards extends StatelessWidget {
  final Color color;

  const ScreenCards({Key? key, required this.color}) : super(key:key);

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
                    'In search of a loving home!\n',
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
