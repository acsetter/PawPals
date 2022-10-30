import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/models/post_model.dart';

class ScreenCards extends StatelessWidget {
  final PostModel post;

  const ScreenCards({ Key? key, required this.post,}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right:10,
        ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height /1.325,
        width: MediaQuery.of(context).size.width ,
        child: Stack(
          children: [

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(post.petPhotoUrl!)
                ),
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
                  '${post.petName}, ${post.petAge}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  )
                ),
                Text(
                    '${post.postDescription}\n',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )
                ),
                /*Row(
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
                )*/
              ],
            )
            )
      ],
    )
    )
    );
  }
}
