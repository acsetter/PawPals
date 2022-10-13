import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/widgets/profile/user_preferences.dart';
import '../../constants/app_icons.dart';
import '../../widgets/profile/profile_widget.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  final String screenTitle = "My Profile";
  final String buttonLabel = "Edit Profile";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  // You must call @override on the build method

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
        appBar: OurAppBar.build(screenTitle),
        // The main body of the Screen:
        body: FormWrapper(
          children: [
            FieldWrapper(
                child: ProfilePhotoWidget(
                  photoUrl: user.photoUrl, onPressed: () {},)
            ),
            const FieldWrapper(
              child: UserInformationWidget()
              ),
            /*
            FieldWrapper(
              child: buildPostArea(),
            ),
             */
            FieldWrapper(
              child: OurOutlinedButton(
                // method invoked when a user presses this button
                  onPressed: () {
                    // This adds a page to the stack and displays the next screen.
                    // You can keep stacking screens by calling
                    // `Get.to(() => MyNextScreen())` on subsequent screens.
                    Get.to(() => const EditProfileScreen());
                  },
                  label: buttonLabel,
                icon: AppIcons.edit,
              ),
            )
          ],
        )
    );
  }
}

