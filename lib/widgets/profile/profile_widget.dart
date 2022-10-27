import 'package:flutter/material.dart';
import '../../constants/app_data.dart';
import '../../controllers/app_user.dart';
import '../../models/user_model.dart';

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
    required this.onPressed, required this.photoUrl,
  }) : super(key: key);

  @override // Overriding build method
  Widget build(BuildContext context) {
    return Center(
      child: Ink.image( // Creates a widget for displaying an image using Ink Package
        image: AppData.profileMan,  // Grabbing photo from photoUrl defined by user model
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

  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = AppUser.instance.userModel;

    return Column(  // Building widget for user information
        children: [
          Text(
            '${userModel?.username}', // Fetching user username
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24), // Setting text style
          ),
          const SizedBox(height: 4),  // Creating container for user first / user last
          Text(
            '${userModel?.first} ${userModel?.last}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple), // Setting text style
          ),
          const SizedBox(height: 4),  // Creating container for email
          Text(
            '${userModel?.email}',  // Fetching user email
            style: const TextStyle(color: Colors.grey), // Setting the text style (color)
          ),
        ]
    );
  }
}

