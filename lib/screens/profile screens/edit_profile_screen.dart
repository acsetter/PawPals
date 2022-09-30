import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paw_pals/screens/examples/example_stack_screen.dart';
import 'package:paw_pals/screens/profile%20screens/profile_screen.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class EditProfileScreen extends StatelessWidget {
  final String screenTitle = "Edit Profile";
  final String exampleText = "The Edit Profile Screen.";
  final String buttonLabel = "Save Changes";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const EditProfileScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
        appBar: OurAppBar.build(screenTitle),
        // The main body of the Screen:
        body: FormWrapper(
          children: [
            FieldWrapper(
              child: Text(exampleText, textAlign: TextAlign.center),
            ),
          ],
        )
    );
  }
}