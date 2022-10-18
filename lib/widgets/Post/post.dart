import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';

import '../../models/post_model.dart';

class Post extends StatelessWidget {
  PostModel post = AppData.fakePost;

  Post({super.key});
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right:20,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AppData.siameseCat
                ),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  ),
                ]
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            Positioned(
              bottom: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${AppData.fakePost.petName}, 4',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                  ),
                  ),
                  Text('Male, Wilmington',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 8, right: 8,
                      ),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AppData.siameseCat,
                            fit: BoxFit.cover
                          ),
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                  ],)
                ]
              ),
            )
          ],
        ),
      ),
    );

  }


}