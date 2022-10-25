
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paw_pals/widgets/bars/app_bar_dropdown.dart';
import 'package:paw_pals/widgets/forms/preference_form.dart';

///
class OurAppBarpref {
  OurAppBarpref._();

  static AppBar build(String title, BuildContext context,) {
    return AppBar(
      title: Text(title),

      actions: [
        AppBarPopup.build(context)
      ],
    );
  }
}