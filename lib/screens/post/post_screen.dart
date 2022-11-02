import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/Post/DetailedPost.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class PostScreen extends StatelessWidget {
  final String screenTitle = "Post";
  final String exampleText = "Post Screen";
  final String buttonLabel = "Next Screen";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const PostScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
        appBar: OurAppBar.build(screenTitle),
        // The main body of the Screen:
        body: DetailedPost()
          //children: [
            //FieldWrapper(
              //child: Text(exampleText, textAlign: TextAlign.center),
            );


              //FieldWrapper(
              //child: OurOutlinedButton(
                // method invoked when a user presses this button
                  //onPressed: () {
      // This adds a page to the stack and displays the next screen.
      // You can keep stacking screens by calling
      // `Get.to(() => MyNextScreen())` on subsequent screens.
      //Get.to(() => const PostScreen());
      //},
      //label: buttonLabel
      //),
      //)
      //],
      //)
      //);
  }
}