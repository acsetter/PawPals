import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import '../../constants/app_data.dart';
import '../../constants/app_icons.dart';
import '../../widgets/profile/profile_widget.dart';
import '../../widgets/wrappers/field_wrapper.dart';
import '../../widgets/wrappers/form_wrapper.dart';
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
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
        appBar: OurAppBar.build(screenTitle),
        body: SingleChildScrollView(
          child: Column(
              children: [
                FieldWrapper(
                  child: ProfilePhotoWidget(
                    onPressed: () {}, photoUrl: '',),
                ),
                const FieldWrapper(
                  child: UserInformationWidget(),
                ),
                FormWrapper(
                  children: [
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
                  ]
                ),

                GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(10, (index) {
                    return Center(
                      child: Image( // Creates a widget for displaying an image using Ink Package
                        image: AppData.siameseCat,  // Grabbing photo from model
                        fit: BoxFit.cover,  // Applies box mask to image
                        width: 150, // Setting width/height of the user's post
                        height: 150,
                        // Allows user to press their profile photo
                      ),
                    );
                  }),
                ),
              ]
          ),
        )
    );
  }
}

