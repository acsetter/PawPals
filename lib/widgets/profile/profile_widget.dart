import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/profile/user_preferences.dart';

/*
ProfilePhotoWidget: fetch and build the user's profile image --> Utilizes web URL from dummy user
information (usermodeltest.dart) until database is built.
 */

class ProfilePhotoWidget extends StatelessWidget {
  final String photoUrl;
  final VoidCallback onPressed;

  /* This is the constructor. All widgets should have a Key key as optional
  parameter in their constructor. Key is something used by flutter engine
  at the step of recognizing which widget in a list as changed.
  You must call @override on the build method */

  const ProfilePhotoWidget({
    Key? key,
    required this.photoUrl,
    required this.onPressed,
  }) : super(key: key);

  @override // Overriding build method
  Widget build(BuildContext context) {
    final photo = NetworkImage(photoUrl);
    return Center(
      child: Ink.image( // Creates a widget for displaying an image using Ink Package
        image: photo,  // Grabbing photo from photoUrl defined by user model
        fit: BoxFit.cover,  // Applies box mask to image
        width: 128, // Setting width/height of the user's profile image
        height: 128,
        child: InkWell(onTap: onPressed),  // Allows user to press their profile photo
      ),
    );
  }
}


/* UserInformationWidget: to build the User's Information --> Takes dummy user information from usermodeltest.dart
until database is created */

class UserInformationWidget extends StatelessWidget {
  final user = UserPreferences.myUser;

  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(  // Building widget for user information
      children: [
        Text(
          user.username, // Fetching user username
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), // Setting text style
        ),
        const SizedBox(height: 4),  // Creating container for user first / user last
        Text(
          '${user.first} ${user.last}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple), // Setting text style
        ),
        const SizedBox(height: 4),  // Creating container for email
        Text(
          user.email,  // Fetching user email
          style: TextStyle(color: Colors.grey), // Setting the text style (color)
        ),
        /* The below is a a test of GridView to add the user's posts on their profile.
        const SizedBox(height: 30),
        GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16),
            children: [
              Container()
              //Image.network('https://thumbs.dreamstime.com/b/welsh-corgi-pembroke-dog-standing-studio-looking-forward-67971970.jpg'),
              //Image.network('https://thumbs.dreamstime.com/b/welsh-corgi-pembroke-dog-standing-studio-looking-forward-67971970.jpg'),
             //Image.network('https://thumbs.dreamstime.com/b/welsh-corgi-pembroke-dog-standing-studio-looking-forward-67971970.jpg'),
         */
            ]
        );
  }
}

// Below is more testing to try and get the user's posts to showcase on their profile (WIP)

 /*Widget to Build the "User's Posts" Area --> The user should be able to scroll through the posts that they
 have made on their profile


class UserPostAreaWidget extends StatelessWidget {
  UserPostAreaWidget({super.key});

  final numbers = List.generate(6, (index) => '$index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
          separatorBuilder: (context, int) {
            return Divider(color: Colors.black,);
          },
          itemBuilder: (BuildContext context, int index) {
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              children: List.generate(6, (index) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Post # : $index',
                    ),
                  ),
                );
              }),
            );
          },
          itemCount: 4,
        ));
 */