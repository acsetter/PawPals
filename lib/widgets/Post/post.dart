import 'package:flutter/material.dart';


class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Card(
        elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          color: Colors.amber,
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 500,
            child: Column(
              children: [
                Text(
              "Pet's Name",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Image.asset('images/Rocket.jpg',width:800, height:350),
             SizedBox(height:10.0),
            Text(
              'more things here',
              //style:TextStyle(),
            )

              ],
            ),
          )

        ),
      );
  }


}