import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';

import '../../constants/app_info.dart';

/// Used by [OurTextField.validator].
typedef FormFieldValidator<T> = String? Function(T? value);

/// A widget built for new-password input. A specific [TextEditingController]
/// and [FormFieldValidator] must be specified in the parent form and passed
/// down to this widget.
class NewPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String?> validator;

  const NewPasswordField({
    super.key,
    required this.controller,
    required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OurTextField(
          labelText: AppLocalizations.of(context).translate("field-labels.password"),
          controller: controller,
          validator: validator,
          icon: AppIcons.password,
          hideText: true,
          autocorrect: false,
          maxLength: AppInfo.maxPasswordLength,
        ),
        OurTextField(
          labelText: AppLocalizations.of(context).translate("field-labels.retype-password"),
          icon: AppIcons.retypePassword,
          hideText: true,
          maxLength: AppInfo.maxPasswordLength,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return AppLocalizations.of(context).translate("errors.empty-password");
            }
            if (controller.text.trim() != val) {
              return AppLocalizations.of(context).translate("errors.mismatched-password");
            }
            return null;
          },
        ),
      ],
    );
  }
}