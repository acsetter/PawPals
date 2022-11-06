import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_info.dart';
import '../../screens/post/post_screen.dart';
import '../buttons/contained_button.dart';
import '../fields/our_text_field.dart';
import '../wrappers/field_wrapper.dart';
import '_form_validation.dart';
/*
class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => CreatePostFormState();
}

class CreatePostFormState extends State<CreatePostForm> with FormValidation {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();
  final TextEditingController postDescriptionController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  String focusedField = "none";

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
            OurTextField(
              controller: petNameController,
              labelText: translate("field-labels.petName"),
              validator: petNameValidator,
              icon: AppIcons.user,
              maxLength: AppInfo.maxNameLength,
            ),
            OurTextField(
              controller: petAgeController,
              labelText: translate("field-labels.petAge"),
              validator: petAgeValidator,
              icon: AppIcons.user,
              maxLength: AppInfo.maxPasswordLength,
            ),
            OurTextField(
              controller: postDescriptionController,
              labelText: translate("field-labels.postDescription"),
              validator: postDescriptionValidator,
              icon: AppIcons.user,
              maxLength: AppInfo.maxEmailLength,
            ),
            FieldWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ContainedButton(
                        icon: AppIcons.signUp,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirestoreService
                                .createPost()
                                .then((String val) {
                              if (val.isNotEmpty) {
                                Get.snackbar("Error:", translate('errors.$val'),
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 7),
                                    colorText: Theme.of(context).errorColor
                                );
                              } else {
                                Get.offAll(const PostScreen());
                              }
                            });
                          }
                        },
                        label: translate("btn-labels.create-post"),
                      )
                    ],
                  )


          ]
      ),


    );
  }
*/

/*
  @override
  void dispose() {
    petNameController.dispose();
    petAgeController.dispose();
    postDescriptionController.dispose();
    super.dispose();
  }
}

 */