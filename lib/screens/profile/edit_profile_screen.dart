import 'package:flutter/material.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/widgets/profile/edit_profile_widget.dart';

/// A screen that allows the user to change certain personal information.
///
/// This screen is navigated to from the user's profile page.
/// If the user successfully edits their information it will be updated on
/// their my profile screen.
/// If the user decides they do not want to make changes, they may hit the
/// back button to abort.
class EditProfileScreen extends StatelessWidget {
  final String exampleText = "The Edit Profile Screen.";
  final String buttonLabel = "Save Changes";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const EditProfileScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: StreamBuilder(
        stream: AppUser.instance.appUserChanges(),
        builder: (context, snapshot) {
          if (AppUser.instance.userModel != null) {
            UserModel? userModel = AppUser.instance.userModel;

            return SingleChildScrollView(
                child: FormWrapper(
                  children: [EditProfile(userModel: userModel)],
                )
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}