import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/logout_popup.dart';

/// An app bar for the user's profile that will display the logout button.
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
