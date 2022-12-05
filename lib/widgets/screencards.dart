import 'package:flutter/material.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:paw_pals/widgets/Post/detailed_post.dart';

class ScreenCards extends StatelessWidget {
  final PostModel post;

  const ScreenCards({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? image = post.petPhotoUrl;
    if (post.petPhotoUrl == null) {
      image =
          'https://firebasestorage.googleapis.com/v0/b/paw-pals-uncw.appspot.com/o/posts%2FJuYp1W7HPJcB5Orl5UR5?alt=media&token=c2baf8d2-5deb-422e-8ea9-8f173116c9df';
    }

    return Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.325,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(image!)),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(3, 3),
                        )
                      ]),
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
                      )),
                ),
                Positioned(
                    bottom: 30,
                    left: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => DetailedPost(post: post));
                          },
                          child: Text('${post.petName}, ${post.petAge}, ${post.petGender?.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  )),
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
                    ))
              ],
            )));
  }
}
