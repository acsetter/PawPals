import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/widgets/buttons/contained_button.dart';
import 'package:paw_pals/widgets/fields/new_password_field.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';
import 'package:paw_pals/widgets/forms/_form_validation.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> with FormValidation {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String focusedField = "none";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // may be useful for validation
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OurTextField(controller: emailController,
            labelText: fetch("field-labels.email"),
            validator: emailValidator,
            icon: AppIcons.email
          ),
          NewPasswordField(
            controller: passwordController,
            validator: newPasswordValidator,
          ),
          OurTextField(
            labelText: fetch("field-labels.first-name"),
            validator: firstNameValidator,
            controller: firstNameController,
            icon: AppIcons.user,
          ),
          OurTextField(
            labelText: fetch("field-labels.last-name"),
            validator: lastNameValidator,
            controller: lastNameController,
            icon: AppIcons.users,
          ),
          FieldWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContainedButton(
                  icon: AppIcons.signUp,
                  onPressed: () {
                    //TODO: Interface with database for sign up here.
                    if (_formKey.currentState!.validate()) {
                      AuthService.signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    }
                  },
                  label: fetch("btn-labels.sign-up"),
                )
              ],
            )
          )
        ]
      )
    );
  }
}