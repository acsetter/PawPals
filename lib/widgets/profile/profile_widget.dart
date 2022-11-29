import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/app_data.dart';
import '../../controllers/app_user.dart';
import '../../models/user_model.dart';


/// Utilizes CachedNetworkImage to display a photo
/// of the user's choosing on their profile page.  If no profile photo is chosen
/// yet, a default profile photo will display.
class ProfilePhotoWidget extends StatelessWidget {
  final String photoUrl;
  final VoidCallback onPressed;

  const ProfilePhotoWidget({
    Key? key,
    required this.onPressed, required this.photoUrl,
  }) : super(key: key);

  @override // Overriding build method
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<UserModel?>(
          // Stateful widget updates via a stream:
          // stream: AppUser.instance.appUserChanges(),
          // builder is called every time the stream ^ gets an update
            builder: (BuildContext context, _) {
              // the '_' is the data-snapshot returned by the stream, which is
              // fine to use, but we can also just fetch the same data
              // directly from AppUser:
              UserModel? userModel = AppUser.instance.userModel;

              if (userModel != null) {
                if (userModel.photoUrl != null) {
                  return CachedNetworkImage( // CachedNetworkImage shows a network image, using a cache mechanism
                    imageUrl: userModel.photoUrl!,
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                    placeholder: (context,
                        url) => const CircularProgressIndicator(), // This will display a circular progress indicator until the photo is loaded

                  );
                }
                else { // Anytime a new user signs up and views their profile, a default profile photo will display until it is changed
                  return Image(
                      image: AppData.defaultProfile,
                      fit: BoxFit.cover,
                      width: 128,
                      height: 128,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            )
                        );
                      }
                  );
                }
              }
              else {
                return const Text("No user found!");
              }
            })
    );
  }
}

/// The UserInformationWidget allows for the stream of data from
/// the database to be displayed on the user's profile page.
/// If the UI renders before the data does, a "Loading or error" message will
/// be displayed while the data continues to load up.
class UserInformationWidget extends StatelessWidget {

  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return Text('  ${userModel.username}\n${userModel.first} ${userModel.last}',
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

  }


