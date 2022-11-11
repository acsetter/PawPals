import 'package:flutter/material.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/Post/DetailedPost.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class PostScreen extends StatelessWidget {
  final String screenTitle = "Post";

  const PostScreen({super.key, required PostModel PostModel});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
        appBar: OurAppBar.build(screenTitle),
        // The main body of the Screen:
        body: const DetailedPost(),

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