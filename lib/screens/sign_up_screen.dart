import 'package:flutter/material.dart';

import 'package:paw_pals/widgets/forms/signup_form.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

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