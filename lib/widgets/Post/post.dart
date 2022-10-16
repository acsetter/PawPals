import 'package:flutter/material.dart';


class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.amber,
          child: Container(
            height:100,
            child:Column(
              children: const [
                Text(
                  "Dog's Name",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                )
              ],
            )
          )
        ),
      ),
    );
  }


}