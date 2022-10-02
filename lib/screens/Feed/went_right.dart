import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/screens/Feed/went_left.dart';
import 'package:paw_pals/screens/home_screen.dart';

import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class RightScreen extends StatelessWidget {
  final String screenTitle = "Feed Screen";
  final String exampleText = "You Went Right 'Screen'";
  final String buttonLabelLeft = "left swipe (For Later)";
  final String buttonLabelRight = "right swipe (For Later)";
  final String buttonLabelHome = "Back to HomePage (just for now)";



  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const RightScreen({super.key});

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
            FieldWrapper(
              child: OurOutlinedButton(
                // method evoked when a user presses this button
                  onPressed: () {

                    // This adds a page to the stack and displays the next screen.
                    // You can keep stacking screens by calling
                    // `Get.to(() => MyNextScreen())` on subsequent screens.
                    Get.to(() => const LeftScreen());
                  },
                  label: buttonLabelLeft


              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                // method evoked when a user presses this button
                  onPressed: () {
                    // This adds a page to the stack and displays the next screen.
                    // You can keep stacking screens by calling
                    // `Get.to(() => MyNextScreen())` on subsequent screens.
                    Get.to(() => const RightScreen());
                  },
                  label: buttonLabelRight

              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                // method evoked when a user presses this button
                  onPressed: () {
                    // This adds a page to the stack and displays the next screen.
                    // You can keep stacking screens by calling
                    // `Get.to(() => MyNextScreen())` on subsequent screens.
                    Get.to(() => const HomeScreen());
                  },
                  label: buttonLabelHome

              ),
            )
          ],
        )
    );
  }
}