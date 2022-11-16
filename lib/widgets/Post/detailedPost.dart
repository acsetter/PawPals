import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class DetailedPost extends StatelessWidget{
  final PostModel? post;

  const DetailedPost({super.key, required this.post});


  @override
  Widget build(BuildContext context) {

    return Scaffold(


        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post!.petPhotoUrl!)
                          )
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          margin: const EdgeInsets.only(left:15),
                          child: Text('${post?.petName}',
                            style: const TextStyle(fontFamily: "Proxima-Nova-Bold",
                              fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400
                            ),),

                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text('${post?.petAge}, ${post?.petGender?.name}, Wilmington',
                        style: const TextStyle(fontFamily: "Proxima-Nova-Bold",
                          fontSize: 25, color: Colors.black, fontWeight: FontWeight.w400
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
                      child: Text('${post?.postDescription}', style: const TextStyle(fontFamily: "ProximaNova-Regular",
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
                          child:
                          Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  //color: const Color(0xFF00C853).withOpacity(0.25)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left:10, top: 6),
                                child:LayoutBuilder(builder: (context, constraints) {
                                  if(post?.isPetFriendly == true){
                                    return Container(
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: const Color(0xFF00C853).withOpacity(0.25)
                                        ),
                                        child: const Text('Pet Friendly',
                                        style: TextStyle(fontFamily: "ProximaNova-Regular",
                                        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
                                      ),));
                                  }else{
                                    return Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: const Color(0xFFFF3D00).withOpacity(0.25)),
                                        child: const Text('Not Pet Friendly',
                                      style: TextStyle(fontFamily: "ProximaNova-Regular",
                                          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,top: 6),
                                  child:LayoutBuilder(builder: (context, constraints) {
                                    if(post?.isKidFriendly == true){
                                      return Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          color: const Color(0xFF00C853).withOpacity(0.25)
                                    ),
                                          child: const Text('Kid Friendly',
                                        style: TextStyle(fontFamily: "ProximaNova-Regular",
                                            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
                                        ),));
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


                )],

            ),
          ),
        );


  }



}