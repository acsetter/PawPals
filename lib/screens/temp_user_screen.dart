import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/widgets/wrappers/auth_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/constants/app_streams.dart';
import 'package:paw_pals/screens/login_screen.dart';

class TempUserScreen extends StatelessWidget {
  const TempUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      home: FormWrapper(
          children: [
            FieldWrapper(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: AppStreams.userStream,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data?.data().toString() ?? "");
                      }

                      return const Text("");
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