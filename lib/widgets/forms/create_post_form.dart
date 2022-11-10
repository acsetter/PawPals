import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:paw_pals/services/firestore_service.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_info.dart';
import '../../constants/app_types.dart';
import '../../models/post_model.dart';
import '../../screens/post/post_screen.dart';
import '../buttons/contained_button.dart';
import '../fields/our_text_field.dart';
import '../fields/our_text_field_2.dart';
import '../wrappers/field_wrapper.dart';
import '_form_validation.dart';



PetGender? dataPetGender = PostModel(postId: '', uid: '',).petGender;
bool? dataPetFriend = PostModel(postId: '', uid: '').isPetFriendly;
bool? dataKidFriend = PostModel(postId: '', uid: '').isPetFriendly;



class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => CreatePostFormState();
}

class CreatePostFormState extends State<CreatePostForm> with FormValidation {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();
  final TextEditingController postDescriptionController = TextEditingController();
  late final List<PostModel> post;


  final _formKey = GlobalKey<FormState>();
  PetGenderOptionsPost? _petGender;
  PetFriendOptionsPost? _petFriend;
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
              labelText: "Pet Name",
              validator: petNameValidator,
              icon: AppIcons.paw,
              maxLength: AppInfo.maxNameLength,
            ),
            OurTextField2(
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
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Pet Gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetGenderOptionsPost.petGenderMale,
                      groupValue: _petGender,
                      onChanged: ((PetGenderOptionsPost? value) {
                        setState(() {
                          _petGender = value;
                          if (value == null) {
                            userPetGenderPref = null;
                          } else {
                            userPetGenderPref = PetGender.male;
                          }
                          print(value);
                        });
                      })),
                  const Text("Male"),
                  Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetGenderOptionsPost.petGenderFemale,
                      groupValue: _petGender,
                      onChanged: ((PetGenderOptionsPost? value) {
                        setState(() {
                          _petGender = value;
                          if (value == null) {
                            userPetGenderPref = null;
                          } else {
                            userPetGenderPref = PetGender.female;
                          }
                          print(value);
                        });
                      })),
                  const Text("Female"),
                ]),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Friendliness",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetFriendOptionsPost.petIsKidFriend,
                      groupValue: _petFriend,
                      onChanged: ((PetFriendOptionsPost? value) {
                        setState(() {
                          _petFriend = value;
                          if (value == null) {
                            userIsPetFriendlyPref = null;
                            userIsKidFriendlyPref = null;
                          } else {
                            userIsKidFriendlyPref = false;
                            userIsPetFriendlyPref = true;
                          }
                          print(value);
                        });
                      })),
                  const Text("Kid Friendly"),
                  Radio(
                      activeColor: AppColors.primary,
                      toggleable: true,
                      value: PetFriendOptionsPost.petIsPetFriend,
                      groupValue: _petFriend,
                      onChanged: ((PetFriendOptionsPost? value) {
                        setState(() {
                          _petFriend = value;
                          if (value == null) {
                            userIsPetFriendlyPref = null;
                            userIsKidFriendlyPref = null;
                          } else {
                            userIsKidFriendlyPref = true;
                            userIsPetFriendlyPref = false;
                          }
                          print(value);
                        });
                      })),
                  const Text("Pet Friendly"),
                ]),
              ],
            ),


]


            )
            /*FieldWrapper(
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

             */


    );

  }
  }


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