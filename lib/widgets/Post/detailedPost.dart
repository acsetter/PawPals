import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';
import '../../models/post_model.dart';

class DetailedPost extends StatelessWidget{
  final PostModel post = AppData.fakePost;

  DetailedPost({super.key});
  @override
  Widget build(BuildContext context){

    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: [

            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/siamese_cat.jpg"),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/siamese_cat.jpg"),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Text('${AppData.fakePost.petName}',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text('4, Male, Wilmington',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]
            ),

            Positioned(
              left: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height,
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              ),
            ),
            Positioned(
                right: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height,
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.black,
                ),
            ),
          ]

        ),


      )
    );
  }


}