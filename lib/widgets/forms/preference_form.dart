import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/pref_model.dart';

enum PetTypeOptions { petTypeCat, petTypeDog }

enum PetGenderOptions { petGenderMale, petGenderFemale }

enum PetFriendOptions { petIsKidFriend, petIsPetFriend }

List<PetType>? dataPetTypes = PreferencesModel().petTypes;
PetGender? dataPetGender = PreferencesModel().petGender;
bool? dataPetFriend = PreferencesModel().isPetFriendly;
bool? dataKidFriend = PreferencesModel().isPetFriendly;
int? dataMinAge = PreferencesModel().minAge;
int? dataMaxAge = PreferencesModel().maxAge;
int? dataSearchRadius = PreferencesModel().searchRadius;

List<PetType>? userPetTypePref = isDatabaseNullChecker(dataPetTypes, 0);
PetGender? userPetGenderPref = isDatabaseNullChecker(dataPetGender, 1);
bool? userIsPetFriendlyPref = isDatabaseNullChecker(dataPetFriend, 2);
bool? userIsKidFriendlyPref = isDatabaseNullChecker(dataKidFriend, 3);
double? userMinAgePref = isDatabaseNullChecker(dataMinAge, 4);
double? userMaxAgePref = isDatabaseNullChecker(dataMaxAge, 5);
int? userSearchRadiusPref = isDatabaseNullChecker(dataSearchRadius, 6);

isDatabaseNullChecker(var dataFromDatabase, int type) {
  if (dataFromDatabase == null) {
    switch (type) {
      case 0:
        return null;
      case 1:
        return null;
      case 2:
        return null;
      case 3:
        return null;
      case 4:
        return 0.0;
      case 5:
        return 25.0;
      case 6:
        return 100;
      default:
    }
  } else {
    return dataFromDatabase;
  }
}

petTypeBoxes(List<PetType>? dataFromDatabse) {
  var temp;
  if (dataFromDatabse?.length == 0 ||
      dataFromDatabse?.length == 2 ||
      dataFromDatabse == null) {
    temp = null;
    return temp;
  }
  if (dataFromDatabse[0] == PetType.dog) {
    temp = PetTypeOptions.petTypeDog;
    return temp;
  }
  if (dataFromDatabse[0] == PetType.cat) {
    temp = PetTypeOptions.petTypeCat;
    return temp;
  }
}

petGenderBoxes(PetGender? dataFromDatabase) {
  var temp;
  if (dataFromDatabase == null) {
    return temp = null;
  }
  if (dataFromDatabase == PetGender.male) {
    return temp = PetGenderOptions.petGenderMale;
  }
  if (dataFromDatabase == PetGender.female) {
    return temp = PetGenderOptions.petGenderFemale;
  }
}

petFriendBoxes(bool? dataFromDatabaseKid, bool? dataFromDatabasePet) {
  var temp;
  if (dataFromDatabaseKid == true && dataFromDatabasePet == true) {
    return temp = null;
  }
  if (dataFromDatabaseKid == true && dataFromDatabasePet == false) {
    return temp = PetFriendOptions.petIsKidFriend;
  }
  if (dataFromDatabaseKid == false && dataFromDatabasePet == true) {
    return temp = PetFriendOptions.petIsPetFriend;
  }
}

petAgeRangeStatePreserve(double? dataMinAge, double? dataMaxAge) {
  List<double?> temp = [];
  if (dataMinAge == Null && dataMaxAge == Null) {
    return temp = [0, 25];
  } else {
    return temp = [dataMinAge, dataMaxAge];
  }
}

petSearchRadiusStatePreserve(int? dataSearchRadius) {
  if (dataSearchRadius == Null) {
    return 100;
  } else {
    return dataSearchRadius;
  }
}

class PreferenceForm extends StatefulWidget {
  const PreferenceForm({super.key});

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  PetTypeOptions? _petType;
  PetGenderOptions? _petGender;
  PetFriendOptions? _petFriend;

  @override
  Widget build(BuildContext context) {
    var petTypeCheck = petTypeBoxes(userPetTypePref);
    _petType = petTypeCheck;
    var petGenderCheck = petGenderBoxes(userPetGenderPref);
    _petGender = petGenderCheck;
    var friendlyCheck =
        petFriendBoxes(userIsKidFriendlyPref, userIsPetFriendlyPref);
    _petFriend = friendlyCheck;

    List<double?> petAgeRangeState =
        petAgeRangeStatePreserve(userMinAgePref, userMaxAgePref);
    RangeValues currentPetAgeRangeValues =
        RangeValues(petAgeRangeState[0]!, petAgeRangeState[1]!);

    int? petSearchRadiusState =
        petSearchRadiusStatePreserve(userSearchRadiusPref);
    int? maxRadiusLabel = petSearchRadiusState;
    double currentRadiusValue = petSearchRadiusState!.toDouble();

    return Form(
        child: Column(
      children: [
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
                  value: PetTypeOptions.petTypeDog,
                  groupValue: _petType,
                  onChanged: ((PetTypeOptions? value) {
                    setState(() {
                      _petType = value;
                      if (value == null) {
                        userPetTypePref = null;
                      } else {
                        userPetTypePref = [PetType.dog];
                      }
                      print(value);
                    });
                  })),
              const Text("Dog"),
              Radio(
                  activeColor: AppColors.primary,
                  toggleable: true,
                  value: PetTypeOptions.petTypeCat,
                  groupValue: _petType,
                  onChanged: ((PetTypeOptions? value) {
                    setState(() {
                      _petType = value;
                      if (value == null) {
                        userPetTypePref = null;
                      } else {
                        userPetTypePref = [PetType.cat];
                      }
                      print(value);
                    });
                  })),
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
                  value: PetGenderOptions.petGenderMale,
                  groupValue: _petGender,
                  onChanged: ((PetGenderOptions? value) {
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
                  value: PetGenderOptions.petGenderFemale,
                  groupValue: _petGender,
                  onChanged: ((PetGenderOptions? value) {
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
          Text("Pet friendliness",
              style: TextStyle(fontWeight: FontWeight.bold))
        ]),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Radio(
                  activeColor: AppColors.primary,
                  toggleable: true,
                  value: PetFriendOptions.petIsKidFriend,
                  groupValue: _petFriend,
                  onChanged: ((PetFriendOptions? value) {
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
              const Text("Kid Friendly"),
              Radio(
                  activeColor: AppColors.primary,
                  toggleable: true,
                  value: PetFriendOptions.petIsPetFriend,
                  groupValue: _petFriend,
                  onChanged: ((PetFriendOptions? value) {
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
              const Text("Pet Friendly"),
            ]),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text("Pet Age Range", style: TextStyle(fontWeight: FontWeight.bold))
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${userMinAgePref?.toInt()}"),
            RangeSlider(
              values: currentPetAgeRangeValues,
              max: 25,
              min: 0,
              divisions: 25,
              onChanged: (RangeValues values) {
                setState(() {
                  currentPetAgeRangeValues = values;
                  userMinAgePref = currentPetAgeRangeValues.start;
                  userMaxAgePref = currentPetAgeRangeValues.end;
                });
              },
            ),
            Text("${userMaxAgePref?.toInt()}")
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text("Pet Search Radius",
              style: TextStyle(fontWeight: FontWeight.bold))
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: currentRadiusValue,
              max: 100,
              min: 5,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  currentRadiusValue = value;
                  // minRange = currentRadiusValues.start.toInt();
                  maxRadiusLabel = currentRadiusValue.toInt();
                  userSearchRadiusPref = currentRadiusValue.toInt();
                });
              },
            ),
            Text("$maxRadiusLabel mi")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: () {
                  print(
                      // null will mean no preferance to the database
                      "Pet Type Pref: $userPetTypePref\n"
                      "Pet Gender Pref: $userPetGenderPref\n"
                      "Is Kid Friendly: $userIsKidFriendlyPref\n"
                      "Is Pet Friendly: $userIsPetFriendlyPref\n"
                      "Pet Min Age Pref: ${userMinAgePref?.toInt()}\n"
                      "Pet Max Age Pref: ${userMaxAgePref?.toInt()}\n"
                      "Search Radius Pref: $userSearchRadiusPref\n");
                  //Where data will be sent to database maybe
                },
                child: Text("Save"))
          ],
        )
      ],
    ));
  }
}
