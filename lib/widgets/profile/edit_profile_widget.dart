import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/widgets/image_selector.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_info.dart';
import '../../controllers/app_user.dart';
import '../../controllers/file_controller.dart';
import '../../models/user_model.dart';
import '../buttons/contained_button.dart';
import '../fields/our_text_field.dart';
import '../forms/_form_validation.dart';
import '../wrappers/field_wrapper.dart';


/// The EditProfile widget CURRENTLY allows the user to change their first and
/// last name, eventually the user will be able to change their profile picture
/// as well.  Two text fields assigned respectively to first and last name
/// changes are shown on the edit profile screen.  The user MUST enter
/// a first and last name that they would like to change or else they will not
/// be allowed to save changes with empty values.  They can, however, go back
/// if they have decided they would not like to edit their profile.
/// When the "Save Changes" button is pressed the edited copyWith version
/// of the UserModel that now has the first and last name changes that the user
/// wanted to make is now passed to the database method updateUser(), a copy
/// of the UserModel is necessary because this allows the changes to actually update
/// to the database.
class EditProfile extends StatefulWidget {
  final UserModel? userModel;

  const EditProfile({super.key, this.userModel});

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> with FormValidation {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final FileController fileController = FileController();
  final _formKey = GlobalKey<FormState>();

  UserModel? get _userModel => super.widget.userModel;

  String focusedField = "none";

  @override
  void initState() {
    // auto-fill text-fields if userModel data is not null.
    if (_userModel != null) {
      if (_userModel!.first != null) firstNameController.text = _userModel!.first!;
      if (_userModel!.last != null) lastNameController.text = _userModel!.last!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // may be useful for validation
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageSelector(
              controller: fileController,
              initialUrl: _userModel?.photoUrl,
            ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirestoreService
                              .updateUser(
                                userModel: AppUser.instance.userModel!.copyWith(
                                  first: firstNameController.text.trim(),
                                  last: lastNameController.text.trim()),
                                file: fileController.value)
                              .then((didComplete) => didComplete
                                ? Get.back()
                                : Get.snackbar(
                                'Error: unable to update profile',
                                'Please try again.',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 7),
                                colorText: Theme.of(context).errorColor));
                          }
                        }, label: 'Save Changes', //Button label
                      )
                    ]
                )
            )
          ]
      ),
    );
  }
}