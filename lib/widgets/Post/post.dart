import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class Post extends StatelessWidget {
  final PostModel post;

  const Post({ Key? key, required this.post,}) : super(key:key);
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
                    image: AssetImage(post.petPhotoUrl!)
                ),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(3, 3),
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
                  Text('${post.petName}',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
                  ),
                  Text('${post.petAge}, ${post.petGender}, Wilmington',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 8, right: 8,
                      ),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(post.petPhotoUrl!)
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