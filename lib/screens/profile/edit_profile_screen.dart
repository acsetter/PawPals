import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import '../../widgets/profile/edit_profile_widget.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
          child: FormWrapper(
            children: [EditProfile()],
          )
      ),
    );
  }
}