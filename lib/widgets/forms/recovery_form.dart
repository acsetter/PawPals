// Following along: https://docs.flutter.dev/cookbook/forms/text-field-changes
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/widgets/app_button.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';
import 'package:paw_pals/widgets/forms/_form_validation.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/screens/login_screen.dart';

typedef Func = void Function();
/// Form for user-login. A login request including an email and password is
/// sent on submission of this form.
class EmailForm extends StatefulWidget {

  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => EmailFormState();
}

// Define a corresponding State Class.
// This class holds data related to the form.
class EmailFormState extends State<EmailForm> with FormValidation {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldWrapper(
                child: Text(
                  translate("instructions.recover"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
              OurTextField(
                controller: emailController,
                labelText: translate("field-labels.email"),
                validator: emailValidator,
                icon: AppIcons.email,
              ),
              FieldWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        appButtonType: AppButtonType.contained,
                        icon: AppIcons.send,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthService.sendResetLink(
                              email: emailController.text.trim(),
                            ).then((String val) {
                              if (val.isNotEmpty) {
                                Get.snackbar("Error:",
                                    translate('errors.$val'),
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 7),
                                    colorText: Theme.of(context).errorColor
                                );
                              } else {
                                Get.snackbar("Code Sent:",
                                    translate('instructions.check-email'),
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 7),
                                    colorText: Theme.of(context).primaryColor
                                );
                                Get.offAll(const LoginScreen());
                              }
                            });
                          }
                        },
                        label: translate("btn-labels.send-link"),
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
    super.dispose();
  }
}
