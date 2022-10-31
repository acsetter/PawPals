import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/pref_model.dart';

class PreferenceForm extends StatefulWidget {
  const PreferenceForm({super.key});

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  // Suppose to retrieve data from database
  // idk if this is how its going to work but this what I got to reference
  static List<PetType>? dataPetTypes = PreferencesModel().petTypes;
  static PetGender? dataPetGender = PreferencesModel().petGender;
  static int? dataMinAge = PreferencesModel().minAge;
  static int? dataMaxAge = PreferencesModel().maxAge;
  static int? dataSearchRadius = PreferencesModel().searchRadius;
  static bool? dataPetFriend = PreferencesModel().isPetFriendly;
  static bool? dataKidFriend = PreferencesModel().isPetFriendly;

  // goes to null checker to see if preferance has been changed before and if so
  // then not null and use value retrieved frome the database
  static List<PetType>? userPetTypePref =
      isDatabaseNullChecker(dataPetTypes, 0);
  static PetGender? userPetGenderPref = isDatabaseNullChecker(dataPetGender, 1);
  static bool? userIsPetFriendlyPref = isDatabaseNullChecker(dataPetFriend, 2);
  static bool? userIsKidFriendlyPref = isDatabaseNullChecker(dataKidFriend, 3);
  static double? userMinAgePref = isDatabaseNullChecker(dataMinAge, 4);
  static double? userMaxAgePref = isDatabaseNullChecker(dataMaxAge, 5);
  static int? userSearchRadiusPref = isDatabaseNullChecker(dataSearchRadius, 6);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Used to set up the boxes to match previous preferences
    // State preserve and setters for values
    List<bool?> petTypeBoxBoolnes = petTypeCheckBoxes(userPetTypePref);
    bool? valDog = petTypeBoxBoolnes[0];
    bool? valCat = petTypeBoxBoolnes[1];
    bool? valDogCat = petTypeBoxBoolnes[2];

    List<bool?> petGenderBoxBoolness = petGenderCheckBoxes(userPetGenderPref);
    bool? valFemale = petGenderBoxBoolness[0];
    bool? valMale = petGenderBoxBoolness[1];
    bool? valMaleFemale = petGenderBoxBoolness[2];

    List<bool?> friendlyBoxBoolness =
        petFriendCheckBoxes(userIsKidFriendlyPref, userIsPetFriendlyPref);
    bool? valKidFriend = friendlyBoxBoolness[0];
    bool? valPetFriend = friendlyBoxBoolness[1];
    bool? valPetKidFriend = friendlyBoxBoolness[2];

    List<double?> petAgeRangeState =
        petAgeRangeStatePreserve(userMinAgePref, userMaxAgePref);
    RangeValues currentPetAgeRangeValues =
        RangeValues(petAgeRangeState[0]!, petAgeRangeState[1]!);

    int? petSearchRadiusState =
        petSearchRadiusStatePreserve(userSearchRadiusPref);
    int? maxRadiusLabel = petSearchRadiusState;
    double currentRadiusValue = petSearchRadiusState!.toDouble();

    return Form(
        key: _formKey,
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
                  const Text("Dog"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valDog,
                    onChanged: (value) {
                      userPetTypePref = [PetType.dog];
                      setState(() {
                        valDog = true;
                        valCat = false;
                        valDogCat = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Cat"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valCat,
                    onChanged: (value) {
                      userPetTypePref = [PetType.cat];
                      setState(() {
                        valCat = true;
                        valDog = false;
                        valDogCat = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Both"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valDogCat,
                    onChanged: (value) {
                      userPetTypePref = [PetType.cat, PetType.dog];
                      setState(() {
                        valDogCat = true;
                        valCat = false;
                        valDog = false;
                      });
                    },
                  )
                ])
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Pet Gender",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Male"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valMale,
                    onChanged: (value) {
                      userPetGenderPref = PetGender.male;
                      setState(() {
                        valMale = true;
                        valFemale = false;
                        // valMaleFemale = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Female"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valFemale,
                    onChanged: (value) {
                      userPetGenderPref = PetGender.female;
                      setState(() {
                        valFemale = true;
                        valMale = false;
                        // valMaleFemale = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Both"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valMaleFemale,
                    onChanged: (value) {
                      userPetGenderPref = null;
                      setState(() {
                        valMaleFemale = true;
                        valMale = false;
                        valFemale = false;
                      });
                    },
                  )
                ])
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
                  const Text("Pet Friendly"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valPetFriend,
                    onChanged: (value) {
                      userIsPetFriendlyPref = true;
                      userIsKidFriendlyPref = false;
                      setState(() {
                        valPetFriend = true;
                        valKidFriend = false;
                        valPetKidFriend = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Kid Friendly"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valKidFriend,
                    onChanged: (value) {
                      userIsKidFriendlyPref = true;
                      userIsPetFriendlyPref = false;
                      setState(() {
                        valKidFriend = true;
                        valPetFriend = false;
                        valPetKidFriend = false;
                      });
                    },
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text("Both"),
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: valPetKidFriend,
                    onChanged: (value) {
                      userIsKidFriendlyPref = true;
                      userIsPetFriendlyPref = true;
                      setState(() {
                        valPetKidFriend = true;
                        valKidFriend = false;
                        valPetFriend = false;
                      });
                    },
                  )
                ])
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text("Pet Age Range",
                  style: TextStyle(fontWeight: FontWeight.bold))
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
                      // if preference is set to both then change to null
                      // because both is the default preference
                      if (userPetTypePref?.length == 2) {
                        userPetTypePref = null;
                        print("Pet Type Pref: $userPetTypePref\n");
                      } else {
                        print("Pet Type Pref: $userPetTypePref\n");
                      }
                      print(
                          // null will mean no preferance to the database
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

// Going to be some logic that requires information from the database
// to know if to use starter values or saved ones

  static isDatabaseNullChecker(var dataFromDatabase, int type) {
    if (dataFromDatabase == null) {
      switch (type) {
        case 0:
          return [PetType.dog, PetType.cat];
        case 1:
          return null;
        case 2:
          return true;
        case 3:
          return true;
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

// all of these check save and chosen prefernaces and sets up boxes and sliders
// to match
  static petTypeCheckBoxes(List<PetType>? dataFromDatabse) {
    List<bool> temp = [];
    if (dataFromDatabse?.length == 0 ||
        dataFromDatabse?.length == 2 ||
        dataFromDatabse == null) {
      temp = [false, false, true];
      return temp;
    }
    if (dataFromDatabse[0] == PetType.dog) {
      temp = [true, false, false];
      return temp;
    }
    if (dataFromDatabse[0] == PetType.cat) {
      temp = [false, true, false];
      return temp;
    }
  }

  static petGenderCheckBoxes(PetGender? dataFromDatabase) {
    List<bool?> temp = [];
    if (dataFromDatabase == null) {
      return temp = [false, false, true];
    }
    if (dataFromDatabase == PetGender.male) {
      return temp = [false, true, false];
    }
    if (dataFromDatabase == PetGender.female) {
      return temp = [true, false, false];
    }
  }

  static petFriendCheckBoxes(
      bool? dataFromDatabaseKid, bool? dataFromDatabasePet) {
    List<bool> temp = [];
    if (dataFromDatabaseKid == true && dataFromDatabasePet == true) {
      return temp = [false, false, true];
    }
    if (dataFromDatabaseKid == true && dataFromDatabasePet == false) {
      return temp = [true, false, false];
    }
    if (dataFromDatabaseKid == false && dataFromDatabasePet == true) {
      return temp = [false, true, false];
    }
  }

  static petAgeRangeStatePreserve(double? dataMinAge, double? dataMaxAge) {
    List<double?> temp = [];
    if (dataMinAge == Null && dataMaxAge == Null) {
      return temp = [0, 25];
    } else {
      return temp = [dataMinAge, dataMaxAge];
    }
  }

  static petSearchRadiusStatePreserve(int? dataSearchRadius) {
    if (dataSearchRadius == Null) {
      return 100;
    } else {
      return dataSearchRadius;
    }
  }
}
