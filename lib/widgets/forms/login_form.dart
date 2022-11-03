// Following along: https://docs.flutter.dev/cookbook/forms/text-field-changes
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/widgets/buttons/contained_button.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';
import 'package:paw_pals/widgets/forms/_form_validation.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/screens/home_screen.dart';

typedef Func = void Function();
/// Form for user-login. A login request including an email and password is
/// sent on submission of this form.
class LoginForm extends StatefulWidget {

  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

// Define a corresponding State Class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> with FormValidation {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OurTextField(
                controller: emailController,
                labelText: translate("field-labels.email"),
                validator: emailValidator,
                icon: AppIcons.email,
              ),
              OurTextField(
                controller: passwordController,
                labelText: translate("field-labels.password"),
                validator: passwordValidator,
                icon: AppIcons.password,
                hideText: true,
                autocorrect: false,
              ),
              FieldWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ContainedButton(
                        icon: AppIcons.login,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthService.signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
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
                        label: translate("btn-labels.login"),
                      )
                    ],
                  )
              ),
            ]
        )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}