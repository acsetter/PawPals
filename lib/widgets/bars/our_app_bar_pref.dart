import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/app_bar_dropdown.dart';

///
class OurAppBarPref {
  OurAppBarPref._();

  static AppBar build(
    String title,
    BuildContext context,
  ) {
    return AppBar(
      title: Text(title),
      actions: [AppBarPopup.build(context)],
    );
  }
}
