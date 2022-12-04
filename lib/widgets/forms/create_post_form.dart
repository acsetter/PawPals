import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/constants/app_info.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/widgets/app_image.dart';
import 'package:paw_pals/widgets/app_button.dart';
import 'package:paw_pals/widgets/fields/our_text_field.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/forms/_form_validation.dart';


/// A form to create a post.
///
/// The user must choose a pet name, age, post description, photo, type,
/// and gender before they are allowed to create the post.  Upon validation
/// the form is sent to
class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => CreatePostFormState();
}

class CreatePostFormState extends State<CreatePostForm> with FormValidation {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();
  final TextEditingController postDescriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FileController fileController = FileController();

  PetType? _typeSelection;
  PetGender? _genderSelection;
  bool _kidFriendlySelection = false;
  bool _petFriendlySelection = false;
  bool _isSubmitted = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = AppUser.instance.userModel?.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      FirestoreService.createPost(
        PostModel(
          petName: petNameController.text.trim(),
          petAge: int.parse(petAgeController.text.trim()),
          petGender: _genderSelection,
          petType: _typeSelection,
          isKidFriendly: _kidFriendlySelection,
          isPetFriendly: _petFriendlySelection,
          postDescription: postDescriptionController.text.trim(),
          username: AppUser.instance.userModel?.username,
          email: emailController.text.trim(),
        ), fileController.value!)
          .then((didComplete) {
            if (didComplete) {
              Get.appUpdate();
              Get.offAll(const ProfileScreen());
            } else {
              Get.snackbar(
                "Error: unable to create post",
                "Please try again.",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 7),
                colorText: Theme.of(context).errorColor,
              );
              setState(() {
                _isSubmitted = false;
              });
            }
      });

      return const Center(child: CircularProgressIndicator());
    }
    return Form(
      key: _formKey,
      onChanged: () {
        // may be useful for validation
      },
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
              controller: emailController,
              labelText: "Contact Email",
              validator: emailValidator,
              icon: AppIcons.email,
              maxLength: AppInfo.maxEmailLength,
              // initialValue: AppUser.instance.userModel?.username,
            ),
            OurTextField(
              controller: postDescriptionController,
              labelText: "Post Description",
              validator: postDescriptionValidator,
              icon: AppIcons.message,
              maxLength: AppInfo.maxEmailLength,
              maxLines: 5
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                "Pet Type",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Radio(
                    activeColor: AppColors.primary,
                    toggleable: true,
                    value: PetType.dog,
                    groupValue: _typeSelection,
                    onChanged: ((PetType? value) {
                      if (_typeSelection != null && value == null ) {
                        // unselect PetType preference
                        setState(() {
                          _typeSelection = null;
                        });
                      } else if (value != null) {
                        setState(() {
                          _typeSelection = value;
                        });
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
                      if (_typeSelection != null && value == null ) {
                        // unselect PetType preference
                        setState(() {
                          _typeSelection = null;
                        });
                      } else if (value != null) {
                        setState(() {
                          _typeSelection = value;
                        });
                      }
                    }),
                  ),
                  const Text("Cat"),
                ]),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Pet Gender", style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Radio(
                    activeColor: AppColors.primary,
                    toggleable: true,
                    value: PetGender.male,
                    groupValue: _genderSelection,
                    onChanged: ((PetGender? value) {
                      if (_genderSelection != null && value == null ) {
                        // unselect PetGender preference
                        setState(() {
                          _genderSelection = null;
                        });
                      } else if (value != null) {
                        setState(() {
                          _genderSelection = value;
                        });
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
                      if (_genderSelection != null && value == null ) {
                        // unselect PetGender preference
                        setState(() {
                          _genderSelection = null;
                        });
                      } else if (value != null) {
                        setState(() {
                          _genderSelection = value;
                        });
                      }
                    }),
                  ),
                  const Text("Female"),
                ]),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Pet friendliness",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Checkbox(
                    value: _kidFriendlySelection,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _kidFriendlySelection = val;
                        });
                      }
                    },
                  ),
                  const Text("Kid Friendly"),
                  Checkbox(
                      value: _petFriendlySelection,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _petFriendlySelection = val;
                          });
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
                          setState(() {
                            _isSubmitted = true;
                          });
                        } else if (fileController.value == null) {
                          Get.snackbar(
                            "Error: no pet photo provided",
                            "Please add a pet photo.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 7),
                            colorText: Theme.of(context).errorColor
                          );
                        }
                        // snackbar that let's the user know that they have either
                        // not selected a gender, pet type, or both
                        else if (_genderSelection == null || _typeSelection == null){
                          Get.snackbar('Error: No pet type and/or pet gender selected!',
                              'Please try again.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 7),
                        colorText: Theme.of(context).errorColor);
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
