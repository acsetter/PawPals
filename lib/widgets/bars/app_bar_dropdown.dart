import 'package:flutter/material.dart';

import 'package:paw_pals/widgets/forms/preference_form.dart';
import 'package:paw_pals/constants/app_icons.dart';

class AppBarPopup {
  AppBarPopup._();

  static PopupMenuButton build(
    BuildContext context,
  ) {
    return PopupMenuButton(
      icon: AppIcons.paw,
      tooltip: "Filter",
      constraints: const BoxConstraints(minWidth: 50),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: PreferenceForm(),
          ),
        ];
      },
    );
  }
}
