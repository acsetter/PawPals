import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

/// This is an example of a simple screen that was navigated to from another
/// screen. Use this to get to screens that aren't directly accessible from
/// the navbar.
class ExampleStackScreen extends StatelessWidget {
  final String screenTitle = "Example";
  final String exampleString = "This is an example of a screen "
                               "navigated to by another screen";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter or their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const ExampleStackScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(
      // The bar that goes across the top of the screen:
      appBar: OurAppBar.build(screenTitle),
      // The main body of the Screen
      body: FormWrapper(
        children: [
          FieldWrapper(
            child: Text(exampleString, textAlign: TextAlign.center)
          )
        ],
      )
    );
  }
}