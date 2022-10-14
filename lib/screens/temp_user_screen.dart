import 'package:flutter/material.dart';

import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/services/app_user.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/widgets/wrappers/auth_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/screens/login_screen.dart';

import '../models/user_model.dart';

class TempUserScreen extends StatelessWidget {

  const TempUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      home: FormWrapper(
          children: [
            FieldWrapper(
                child: StreamBuilder<UserModel?>(
                    stream: AppUser.instance.appUserChanges(),
                    builder: (BuildContext context, _) {
                      UserModel? userModel = AppUser.instance.userModel;

                      if (userModel != null) {
                        return Text(userModel.toFirestore().toString());
                      } else {
                        return const Text("Null UserModel");
                      }
                    }
                )
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                label: "Logout",
                onPressed: () {
                  AuthService.signOut();
                },
              ),
            )
          ]),
      login: const LoginScreen()
    );
  }
}