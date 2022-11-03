import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/screens/sign_up_screen.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/forms/login_form.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/constants/app_data.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("page-titles.login")),
      ),
      body: SingleChildScrollView(
        child: FormWrapper(
            children: [
              Image(
                image: AppData.logo,
                width: 160,
                height: 160,
              ),
              Text(
                AppLocalizations.of(context).translate("instructions.login"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const LoginForm(),
              FieldWrapper(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 18.0)
                            ),
                          ),
                          onPressed: () {
                            // TODO: Implement password recovery.
                            print("'Forgot password?' button pressed.");
                          },
                          child: Text(AppLocalizations.of(context).translate("btn-labels.forgot-password")),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0)
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 18.0)
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: Text(AppLocalizations.of(context).translate("btn-labels.sign-up")),
                        ),
                      )
                    ],
                  )
              )
            ]
        ),
      )
    );
  }
}