import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/constants/app_info.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/widgets/app_image.dart';
import 'package:paw_pals/widgets/buttons/app_button.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/forms/_form_validation.dart';

/// Form widget for creating pet adoption posts.
class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> with FormValidation {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();
  final TextEditingController postDescriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FileController fileController = FileController();


  PetType? _typeSelection;
  PetGender? _genderSelection;
  bool _kidFriendlySelection = false;
  bool _petFriendlySelection = false;
  bool isSubmitted = false;


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // make user's account email the default contact email
    emailController.text = FirebaseAuth.instance.currentUser?.email! ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isSubmitted) {
      // Submit button clicked => make request
      FirestoreService.createPost(
          PostModel(
              petName: petNameController.text.trim(),
              petAge: int.parse(petAgeController.text.trim()),
              petGender: _genderSelection,
              petType: _typeSelection,
              isKidFriendly: _kidFriendlySelection,
              isPetFriendly: _petFriendlySelection,
              postDescription: postDescriptionController.text.trim(),
              email: emailController.text.trim()
          ),
          fileController.value!)
          .then((didComplete) {
        if (didComplete) {
          Get.appUpdate();
          Get.offAll(const ProfileScreen()); // Goes back to profile screen
        } else {
          setState(() {
            isSubmitted = false;
          });// Tells the user that an error occurred
          Get.snackbar('Error: unable to create post',
              'Please try again.',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 7),
              colorText: Theme.of(context).errorColor
          );
        }
      }
      );
      // show a loading indicator while form submits to prevent user from
      // making multiple requests.
      return Center(
          heightFactor: MediaQuery.of(context).size.height,
          child: const CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppImage(
              controller: fileController,
              shape: BoxShape.rectangle,
            ),
            OurTextField(
              controller: petNameController,
              labelText: "Pet Name",
              validator: petNameValidator,
              icon: AppIcons.paw,
              maxLength: AppInfo.maxNameLength,
            ),
            OurTextField(
              controller: petAgeController,
              keyboard: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],
              labelText: "Pet Age",
              validator: petAgeValidator,
              icon: AppIcons.cake,
              maxLength: AppInfo.maxPasswordLength,
            ),
            OurTextField(
              controller: postDescriptionController,
              labelText: "Post Description",
              validator: postDescriptionValidator,
              icon: AppIcons.message,
              maxLength: AppInfo.maxEmailLength,
              maxLines: 5
            ),
            OurTextField(
              controller: emailController,
              labelText: "Contact email",
              validator: emailValidator,
              icon: AppIcons.email,
              maxLength: AppInfo.maxEmailLength,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Pet Type:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetType.dog,
                      groupValue: _typeSelection,
                      onChanged: ((PetType? value) {
                        if (value != null) {
                          setState(() => _typeSelection = value);
                        }
                      }),
                    ),
                    const Text("Dog"),
                    Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetType.cat,
                      groupValue: _typeSelection,
                      onChanged: ((PetType? value) {
                        if (value != null) {
                          setState(() => _typeSelection = value);
                        }
                      }),
                    ),
                    const Text("Cat"),
                  ],
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                        "Pet Gender:",
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetGender.male,
                      groupValue: _genderSelection,
                      onChanged: ((PetGender? value) {
                        if (value != null) {
                          setState(() => _genderSelection = value);
                        }
                      }),
                    ),
                    const Text("Male"),
                    Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetGender.female,
                      groupValue: _genderSelection,
                      onChanged: ((PetGender? value) {
                        if (value != null) {
                          setState(() => _genderSelection = value);
                        }
                      }),
                    ),
                    const Text("Female"),
                  ],
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Checkbox(
                    value: _kidFriendlySelection,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _kidFriendlySelection = val);
                      }
                    },
                  ),
                  const Text("Kid Friendly"),
                  Checkbox(
                      value: _petFriendlySelection,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _petFriendlySelection = val);
                        }
                      }
                  ),
                  const Text("Pet Friendly"),
                ]),
              ],
            ),
            FieldWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppButton(
                      appButtonType: AppButtonType.contained,
                      icon: AppIcons.user,
                      onPressed: () {
                        // if statement that validates the text fields and makes sure that the user
                        // selects a gender and type, if not a snackbar is shown throwing the user an error
                        if (_formKey.currentState!.validate()
                            && _genderSelection != null
                            && _typeSelection != null
                            && fileController.value != null
                        ) {
                          // form is valid => enter submit state
                          setState(() => isSubmitted = true);
                        } else if (fileController.value == null) {
                          // show error if no post image selected
                          Get.snackbar(
                            'Error: no image selected',
                            'Please include a photo of the pet.',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 7),
                            colorText: Theme.of(context).errorColor
                          );
                        } else if (_genderSelection == null || _typeSelection == null) {
                          // snackbar that let's the user know that they have either
                          // not selected a gender, pet type, or both
                          Get.snackbar(
                            'Error: No pet type and/or pet gender selected.',
                            'Please select a type and gender.',
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Theme.of(context).errorColor
                          );
                        }
                      },
                      label: "Create Post",
                    )
                  ],
                )
            ),
          ]
      )
    );
  }

  @override
  void dispose() {
    petNameController.dispose();
    petAgeController.dispose();
    postDescriptionController.dispose();
    super.dispose();
  }
}
