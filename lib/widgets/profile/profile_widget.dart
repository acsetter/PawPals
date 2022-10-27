import 'package:flutter/material.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../../constants/app_data.dart';
import '../../controllers/app_user.dart';
import '../../models/user_model.dart';
import '../wrappers/auth_wrapper.dart';
import '../wrappers/field_wrapper.dart';
import '../wrappers/form_wrapper.dart';

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
        image: AppData.profileWoman,  // Grabbing photo from photoUrl defined by user model
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
    return
      SizedBox(
          child: StreamBuilder<UserModel?>(
            // Stateful widget updates via a stream:
              stream: AppUser.instance.appUserChanges(),
              // builder is called every time the stream ^ gets an update
              builder: (BuildContext context, _) {
                // the '_' is the data-snapshot returned by the stream, which is
                // fine to use, but we can also just fetch the same data
                // directly from AppUser:
                UserModel? userModel = AppUser.instance.userModel;

                if (userModel != null) {
                  // Return your widget here and pass the userModel
                  return Text('    ${userModel.username}\n${userModel.first} ${userModel.last}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24));

                  // Setting text style
                } else {
                  // This means the UI rendered before data was available
                  // which means we should show a loading screen
                  return const Text("Loading or error...");
                }
              }
          )
      );
  }

/*
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

 */
  }


