import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/pref_model.dart';

import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/widgets/wrappers/auth_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/models/user_model.dart';

/// For testing auth, database, login, and signup functionality/ cohesion.
class TempUserScreen extends StatelessWidget {

  const TempUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Temp User Screen")),
      body: SingleChildScrollView(
        child: FormWrapper(
            children: [
              FieldWrapper(
                  child: StreamBuilder<UserModel?>(
                    // Stateful widget updates via a stream:
                      stream: AppUser.instance.appUserChanges(),
                      // builder is called every time the stream ^ gets an update
                      builder: (BuildContext context, _) {
                        // the '_' is the data-snapshot returned by the stream, which is
                        // fine to use, but we can also just fetch the same data
                        // directly from AppUser:
                        UserModel? userModel = AppUser.instance.userModel;
                        PreferencesModel prefs = PreferencesModel(
                          // isKidFriendly: true,
                          isPetFriendly: false,
                          minAge: 1,
                          maxAge: 15,
                          petGender: PetGender.female
                        );

                        if (userModel != null) {
                          // Return your widget here and pass the userModel
                          // StorageService.getPhotoURL().then((value) => print(value));
                          return StreamBuilder<List<PostModel>?>(
                              // stream: FirestoreService.getPostsByUser(AppUser.instance.userModel!).asStream(),
                              stream: FirestoreService.getFeedPosts(prefs).asStream(),
                              builder: (BuildContext context, posts) {
                                if (posts.hasData) {
                                  String postStr = "";
                                  for (PostModel post in posts.data!) {
                                    postStr = "$postStr\n$post";
                                  }

                                  return Text(postStr);
                                }

                                return const Text("Loading or Error");
                              }
                          );
                        } else {
                          // This means the UI rendered before data was available
                          // which means we should show a loading screen
                          return const Text("Loading or error...");
                        }
                      }
                  )
              ),
              FieldWrapper(
                child: OurOutlinedButton(
                  label: "Logout",
                  onPressed: () {
                    AuthService.signOut();
                  },
                ),
              ),
              FieldWrapper(
                child: OurOutlinedButton(
                  label: "Generate posts",
                  onPressed: () {
                    FirestoreService.createPost(
                        AppData.feedPost1
                    );
                    FirestoreService.createPost(
                        AppData.feedPost2
                    );
                    FirestoreService.createPost(
                        AppData.feedPost3
                    );
                    FirestoreService.createPost(
                        AppData.feedPost4
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}