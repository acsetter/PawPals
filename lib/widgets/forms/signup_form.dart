import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/constants/app_info.dart';
import 'package:paw_pals/screens/home_screen.dart';
import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/widgets/app_button.dart';
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
  final TextEditingController usernameController = TextEditingController();
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
          OurTextField(
            controller: emailController,
            labelText: translate("field-labels.email"),
            validator: emailValidator,
            icon: AppIcons.email,
            maxLength: AppInfo.maxEmailLength,
          ),
          OurTextField(
            controller: usernameController,
            labelText: translate("field-labels.username"),
            validator: usernameValidator,
            icon: AppIcons.username,
            maxLength: AppInfo.maxUsernameLength,
            showCounter: true,
          ),
          NewPasswordField(
            controller: passwordController,
            validator: newPasswordValidator,
          ),
          OurTextField(
            labelText: translate("field-labels.first-name"),
            validator: firstNameValidator,
            controller: firstNameController,
            icon: AppIcons.user,
            maxLength: AppInfo.maxNameLength,
          ),
          OurTextField(
            labelText: translate("field-labels.last-name"),
            validator: lastNameValidator,
            controller: lastNameController,
            icon: AppIcons.users,
            maxLength: AppInfo.maxNameLength,
          ),
          FieldWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton(
                  appButtonType: AppButtonType.contained,
                  icon: AppIcons.signUp,
                  onPressed: () {
                    //TODO: Interface with database for sign up here.
                    if (_formKey.currentState!.validate()) {
                      AuthService.signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        username: usernameController.text.trim(),
                        first: firstNameController.text.trim(),
                        last: lastNameController.text.trim()
                      ).then((String val) {
                        if (val.isNotEmpty) {
                          Get.snackbar("Error:", translate('errors.$val'),
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 7),
                              colorText: Theme.of(context).errorColor
                          );
                        } else {
                          Get.offAll(const HomeScreen());
                        }
                      });
                    }
                  },
                  label: translate("btn-labels.sign-up"),
                )
              ],
            )
          )
        ]
      )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}