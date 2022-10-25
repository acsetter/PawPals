
import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/forms/preference_form.dart';

import '../../constants/app_icons.dart';

class AppBarPopup {
  AppBarPopup._();

  static PopupMenuButton build(BuildContext context,) {
    return PopupMenuButton(
      icon: AppIcons.paw ,
      tooltip: "Filter",
      constraints: BoxConstraints(minWidth: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (context) {
        return[
          PopupMenuItem<int>(
          child: PreferenceForm(),
          value: 0,
          ),
          ];
      },
    );
  }
}