import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:paw_pals/models/post_model.dart';

class DetailedPost extends StatelessWidget{
  final PostModel post;

  const DetailedPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          shadows: <Shadow>[
            Shadow(
                blurRadius: 16.0,
                color: Color.fromARGB(150, 0, 0, 0)
            )
          ],
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container( // post image:
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(post.petPhotoUrl!),
                      ))),
                Container( // pet name:
                  margin: const EdgeInsets.only(left:15),
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${post.petName}',
                    style: const TextStyle(
                      fontFamily: "Proxima-Nova-Bold",
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 16.0,
                          color: Color.fromARGB(150, 0, 0, 0)
                        )
                      ]
                    ))),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text('${post.petAge}, ${post.petGender?.name}, Wilmington',
                style: const TextStyle(fontFamily: "Proxima-Nova-Bold", fontSize: 25, color: Colors.black, fontWeight: FontWeight.w400
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left:15),
              child: const Text("About Me", style: TextStyle(fontFamily: "Proxima-Nova-Bold",
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
              ),),
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width*0.85,
              child: Text('${post.postDescription}', style: const TextStyle(fontFamily: "ProximaNova-Regular",
                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300
              ),),
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              margin: const EdgeInsets.only(left:10),
              child: Wrap(
                children: [
                  Flexible(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        //color: const Color(0xFF00C853).withOpacity(0.25)
                      ),
                      child: Padding(padding: const EdgeInsets.only(left:10, top: 6), child:LayoutBuilder(builder: (context, constraints) {
                        if(post.isPetFriendly == true){
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: const Color(0xFF00C853).withOpacity(0.25),
                              ),
                              child: const Text('Pet Friendly',
                                style: TextStyle(fontFamily: "ProximaNova-Regular", fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),));
                        }else{
                          return Container(
                              height: 30,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: const Color(0xFFFF3D00).withOpacity(0.25)),
                              child: const Text('Not Pet Friendly', style: TextStyle(fontFamily: "ProximaNova-Regular",
                                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400
                              ),));
                        }
                      })
                      )
                  ),
                ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        //color: const Color(0xFFFF9933).withOpacity(0.25)
                      ),
                      child: Padding(padding: const EdgeInsets.only(left: 10,top: 6),
                          child:LayoutBuilder(builder: (context, constraints) {
                            if(post.isKidFriendly == true){
                              return Container(
                                  height: 30,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: const Color(0xFF00C853).withOpacity(0.25)),
                                  child: const Text('Kid Friendly', style: TextStyle(fontFamily: "ProximaNova-Regular", fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),));
                            }else{
                              return Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: const Color(0xFFFF3D00).withOpacity(0.25)
                                  ),child: const Text('Not Kid Friendly',
                                style: TextStyle(fontFamily: "ProximaNova-Regular",
                                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
                                ),));
                            }
                          })
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}