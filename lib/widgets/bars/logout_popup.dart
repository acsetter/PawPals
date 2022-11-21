import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_icons.dart';
import '../../screens/login_screen.dart';
import '../../services/auth_service.dart';

class LogoutAppBarPopup {
  LogoutAppBarPopup._();

  static PopupMenuButton build(BuildContext context,) {
    return PopupMenuButton(
      icon: AppIcons.logout,
      tooltip: "Logout",
      constraints: const BoxConstraints(minWidth: 50),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (context) {
        return [
           PopupMenuItem<int>(
            value: 0,
            child:
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  onPressed: () {
                    AuthService.signOut().then((value) =>
                        Get.offAll(const LoginScreen()));
                  },
                  child: const Center(child: Text('Logout', style: TextStyle(fontFamily: "Proxima-Nova-Bold"))),
                )

            ),
        ];
      },
    );
  }
}