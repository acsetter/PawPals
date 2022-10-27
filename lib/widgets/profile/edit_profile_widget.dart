
import 'package:flutter/material.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_info.dart';
import '../../controllers/app_user.dart';
import '../../models/user_model.dart';
import '../buttons/contained_button.dart';
import '../fields/our_text_field.dart';
import '../forms/_form_validation.dart';
import '../wrappers/field_wrapper.dart';

class EditProfile extends StatefulWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  EditProfile({super.key});


  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> with FormValidation {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String focusedField = "none";

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = AppUser.instance.userModel;
    return Form(
      key: _formKey,
      onChanged: () {
        // may be useful for validation
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OurTextField(
              labelText: translate("field-labels.first-name"),
              validator: firstNameValidator,
              controller: firstNameController,
              icon: AppIcons.user,
              maxLength: AppInfo.maxNameLength,
            ),
            OurTextField(
              labelText: translate("field-labels.last-name"),
              validator: lastNameValidator,
              controller: lastNameController,
              icon: AppIcons.users,
              maxLength: AppInfo.maxNameLength,
            ),
            FieldWrapper(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ContainedButton(
                        icon: AppIcons.edit,
                        onPressed: () {FirestoreService.updateUser(userModel!);
                        }, label: 'Save Changes',
                      )
                    ]
                )
            )
          ]
      ),
    );

  }


}