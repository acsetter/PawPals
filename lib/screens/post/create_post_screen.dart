import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/forms/create_post_form.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class CreatePostScreen extends StatelessWidget {

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const CreatePostScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
        appBar: AppBar(title: const Text("Create Post")),
        // The main body of the Screen:
        body:
        const SingleChildScrollView(
        child:
            FormWrapper(
        children: [
              CreatePostForm(),
              ]),
        )
            );

  }
}