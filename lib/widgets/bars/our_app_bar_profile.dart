import 'package:flutter/material.dart';
import 'logout_popup.dart';


class OurAppBarProfile {
  OurAppBarProfile._();


  static AppBar build(
      String title,
      BuildContext context,
      ) {
      return AppBar(
        title: Text(title),
        actions: [LogoutAppBarPopup.build(context)],
      );
    }
}