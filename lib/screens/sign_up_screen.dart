import 'package:flutter/material.dart';

import 'package:paw_pals/widgets/forms/signup_form.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

/// A screen that shows a form that allows the user to create an account.
/// This screen is navigated to from the login screen.
/// If the user successfully creates an account, the user will be taken to
/// the home-screen.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: const SingleChildScrollView(
        child: FormWrapper(
          children: [
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}