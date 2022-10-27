import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/pref_model.dart';
import 'package:paw_pals/services/firestore_service.dart';

class PreferenceForm extends StatefulWidget {
  const PreferenceForm({super.key});

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  // Most of this was be trying to retrieve databse information
  // before the retrieval method was made. 
  
  // Suppose to retrieve data from database
  static List<PetType>? dataPetTypes = PreferencesModel().petTypes;
  static PetGender? dataPetGender = PreferencesModel().petGender;
  static int? dataMinAge = PreferencesModel().minAge;
  static int? dataMaxAge = PreferencesModel().maxAge;
  static int? dataSearchRadius = PreferencesModel().searchRadius;
  static bool? dataPetFriend = PreferencesModel().isPetFriendly;
  static bool? dataKidFriend = PreferencesModel().isPetFriendly;

 // goes to null checker to see if preferance has been changed before and if so
 // then not null and use value retrieved frome the database
  static List<PetType>? userPetTypePref = IsDatabaseNullChecker(dataPetTypes, 0);
  static PetGender? userPetGenderPref = IsDatabaseNullChecker(dataPetGender, 1);
  static bool? userIsPetFriendlyPref = IsDatabaseNullChecker(dataPetFriend, 2);
  static bool? userIsKidFriendlyPref = IsDatabaseNullChecker(dataKidFriend, 3);
  static double? userMinAgePref = IsDatabaseNullChecker(dataMinAge, 4);
  static double? userMaxAgePref = IsDatabaseNullChecker(dataMaxAge, 5);
  static int? userSearchRadiusPref = IsDatabaseNullChecker(dataSearchRadius, 6);

    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

  // Used to set up the boxes to match previous preferences
  // State preserve and setters for values
  List<bool> PetTypeBoxBoolnes = PetTypeCheckBoxes(userPetTypePref);
  bool valDog = PetTypeBoxBoolnes[0];
  bool valCat = PetTypeBoxBoolnes[1];
  bool valDogCat = PetTypeBoxBoolnes[2];

  List<bool> PetGenderBoxBoolness = PetGenderCheckBoxes(userPetGenderPref);
  bool valMale = PetGenderBoxBoolness[0];
  bool valFemale = PetGenderBoxBoolness[1];
  // bool valMaleFemale = true;

  List<bool> FriendlyBoxBoolness = PetFriendCheckBoxes(userIsKidFriendlyPref, userIsPetFriendlyPref);
  bool valKidFriend = FriendlyBoxBoolness[0];
  bool valPetFriend = FriendlyBoxBoolness[1];
  bool valPetKidFriend = FriendlyBoxBoolness[2];

  List<double?> PetAgeRangeState = PetAgeRangeStatePreserve(userMinAgePref, userMaxAgePref);
  RangeValues currentPetAgeRangeValues = RangeValues(PetAgeRangeState[0]!, PetAgeRangeState[1]!);

  int? petSearchRadiusState = PetSearchRadiusStatePreserve(userSearchRadiusPref);
  int? maxRadiusLabel = petSearchRadiusState;
  double currentRadiusValue =petSearchRadiusState!.toDouble();

    return Form(
      key: _formKey,
      child: 
      Column(
        children: [
          Row(
            children: const [Text("Pet Type", 
            style: TextStyle(fontWeight: FontWeight.bold),)], 
            mainAxisAlignment: MainAxisAlignment.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              },),
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
              },),
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
              },)
          ],),

          Row(children: [const Text("Pet Gender", 
          style: TextStyle(fontWeight: FontWeight.bold))], 
          mainAxisAlignment: MainAxisAlignment.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              },),
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
              },),
              // Text("Both"),
            // Checkbox(
            //   value: valMaleFemale, 
            //   onChanged: (value) {
            //     userPetTypePref = [PetType.cat, PetType.dog];
            //     setState(() {
            //       valMaleFemale = true;
            //       valMale = false;
            //       valFemale = false;
            //     });
            //   },)
          ],),

          Row(children: [const Text("Pet friendliness", 
          style: TextStyle(fontWeight: FontWeight.bold))], 
          mainAxisAlignment: MainAxisAlignment.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              },),
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
              },),
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
              },)
          ],),
        
        Row(children: [const Text("Pet Age Range", 
        style: TextStyle(fontWeight: FontWeight.bold))], 
        mainAxisAlignment: MainAxisAlignment.center),
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
              },),
              Text("${userMaxAgePref?.toInt()}")
          ],
        ),

        Row(children: [const Text("Pet Search Radius", 
        style: TextStyle(fontWeight: FontWeight.bold))], 
        mainAxisAlignment: MainAxisAlignment.center),
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
              },),
              Text("$maxRadiusLabel mi")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary
            ),
            onPressed: () {
              print(
              "Pet Type Pref: $userPetTypePref\n"
              "Pet Gender Pref: $userPetGenderPref\n"
              "Is Kid Friendly: $userIsKidFriendlyPref\n"
              "Is Pet Friendly: $userIsPetFriendlyPref\n"
              // turned into intergers for future database implementation
              "Pet Min Age Pref: ${userMinAgePref?.toInt()}\n"
              "Pet Max Age Pref: ${userMaxAgePref?.toInt()}\n"
              "Search Radius Pref: $userSearchRadiusPref\n"
              );
              //Where data will be sent to database maybe
            }, 
            child: Text("Save"))
        ],)
        ],
      )
    );
  }
  

// Going to be some logic that requires information from the database 
// to know if to use starter values or saved ones

  static IsDatabaseNullChecker(var dataFromDatabase, int type) {
  if (dataFromDatabase == null) {
    switch (type) {
      case 0:
        return [PetType.dog, PetType.cat];
      case 1:
        return PetGender.male;
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
static PetTypeCheckBoxes(List<PetType>? dataFromDatabse) {
  List<bool> temp = [];
  if (dataFromDatabse?.length == 0 || dataFromDatabse?.length == 2) {
    temp = [false, false, true];
    return temp;
  }
  if (dataFromDatabse?[0] == PetType.dog) {
    temp = [true, false, false];
    return temp;
  }
  if (dataFromDatabse?[0] == PetType.cat) {
    temp = [false, true, false];
    return temp;
  }
}

static PetGenderCheckBoxes(PetGender? dataFromDatabase) {
  List<bool> temp = [];
  if (dataFromDatabase == null || dataFromDatabase == PetGender.male) {
    return temp = [true, false];
  } else {
    return temp = [false, true];
  }
}

static PetFriendCheckBoxes(bool? dataFromDatabaseKid, bool? dataFromDatabasePet) {
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

static PetAgeRangeStatePreserve(double? dataMinAge, double? dataMaxAge) {
  List<double?> temp =[];
  if (dataMinAge == Null && dataMaxAge == Null) {
    return temp = [0, 25];
  } else {
    return temp = [dataMinAge, dataMaxAge];
  }
}

static PetSearchRadiusStatePreserve(int? dataSearchRadius) {
  if (dataSearchRadius == Null) {
    return 100;
  } else {
    return dataSearchRadius;
  }
}
}
