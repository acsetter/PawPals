import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';
import '../../models/post_model.dart';

class DetailedPost extends StatelessWidget{
  final PostModel post = AppData.fakePost;


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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.40,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/siamese_cat.jpg"),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        margin: const EdgeInsets.only(left:30),
                        child: Text('${AppData.fakePost.petName}',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),),

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text('4, Male, Wilmington',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left:30),
                    child: const Text("About Me", style: TextStyle(fontFamily: "Proxima-Nova-Bold",
                        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
                    ),),

                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    width: MediaQuery.of(context).size.width*0.85,
                    child: const Text("Whiskers is looking for a furrever home. He loves to cuddle and lay in the sun.", style: TextStyle(fontFamily: "ProximaNova-Regular",
                        fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300
                    ),),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: const EdgeInsets.only(left: 30,right: 30,),
                    child: Wrap(

                      children: [

                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xFF7FE9F6).withOpacity(0.25)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6 ),
                              child: Text("Cat Friendly", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                  fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                              ),),
                            )
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xFF33C0FF).withOpacity(0.25)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6 ),
                              child: Text("Dog Friendly", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                  fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                              ),),
                            )
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xFFFF9933).withOpacity(0.25)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                              child: Text("Kid Friendly", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                  fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                              ),),
                            )
                        ),
                      ],

                    ),
                  ),

                ],

              ),


            ],

          ),
        )

    );

  }



}