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

  bool valMale = false;
  bool valFemale = false;
  // bool valMaleFemale = true;

  bool valPetFriend = false;
  bool valKidFriend = false;
  bool valPetKidFriend = true;

  RangeValues currentPetAgeRangeValues = const RangeValues(0, 25);
  double currentRadiusValue = 100;
  int? minRange = 0;
  int? maxRange = 100;

  // static var userPrefModel = PreferencesModel.fromFirestore;

  // Most of this was be trying to retrieve databse onformation
  // before the retrieval method was made. 
  
  static List<PetType>? dataPetTypes = PreferencesModel().petTypes;
  PetGender? dataPetGender = PreferencesModel().petGender;
  int? dataMinAge = PreferencesModel().minAge;
  int? dataMaxAge = PreferencesModel().maxAge;
  int? dataSearchRadius = PreferencesModel().searchRadius;
  bool? dataPetFriend = PreferencesModel().isPetFriendly;
  bool? dataKidFriend = PreferencesModel().isPetFriendly;
  
  static List<PetType>? defaultUserPetTypePref;
  PetGender? userPetGenderPref;
  bool? userIsPetFriendlyPref;
  bool? userIsKidFriendlyPref;
  int? userMinAgePref = 0;
  int? userMaxAgePref = 25;
  int? userSearchRadiusPref = 1;


  static List<PetType>?userPetTypePref = IsDatabaseNullChecker(dataPetTypes, defaultUserPetTypePref);
  static var BoxBoolnes = PetTypeCheckBoxes(userPetTypePref);
  bool valDog = BoxBoolnes[0];
  bool valCat = BoxBoolnes[1];
  bool valDogCat = BoxBoolnes[2];


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                PreferencesModel(petTypes: userPetTypePref);
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
                PreferencesModel(petTypes: userPetTypePref);
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
                PreferencesModel(petTypes: userPetTypePref);
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
            //   Text("Both"),
            // Checkbox(
            //   value: valDogCat, 
            //   onChanged: (value) {
            //     userPetTypePref = [PetType.cat, PetType.dog];
            //     setState(() {
            //       valDogCat = true;
            //       valCat = false;
            //       valDog = false;
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
            Text("$userMinAgePref"),
            RangeSlider(
              values: currentPetAgeRangeValues,
              max: 25,
              min: 0,
              divisions: 25,
              // labels: RangeLabels(
              //   currentPetAgeRangeValues.start.round().toString(), 
              //   currentPetAgeRangeValues.end.round().toString()),
              onChanged: (RangeValues values) {
                setState(() {
                  currentPetAgeRangeValues = values;
                  userMinAgePref = currentPetAgeRangeValues.start.toInt();
                  userMaxAgePref = currentPetAgeRangeValues.end.toInt();
                });
              },),
              Text("$userMaxAgePref")
          ],
        ),

        Row(children: [const Text("Pet Search Radius", 
        style: TextStyle(fontWeight: FontWeight.bold))], 
        mainAxisAlignment: MainAxisAlignment.center),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("$minRange mi"),
            Slider(
              value: currentRadiusValue,
              max: 100,
              min: 5,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  currentRadiusValue = value;
                  // minRange = currentRadiusValues.start.toInt();
                  maxRange = currentRadiusValue.toInt();
                  userSearchRadiusPref = currentRadiusValue.toInt();
                });
              },),
              Text("$maxRange mi")
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

  static IsDatabaseNullChecker(var dataFromDatabase, var dataToBeUsed) {
  if (dataFromDatabase == null) {
    print("object");
    return dataToBeUsed;
  } else {
    return dataFromDatabase;
  }
}

static PetTypeCheckBoxes(List<PetType>? dataFromDatabse) {
  if (dataFromDatabse == null || dataFromDatabse == [PetType.dog, PetType.cat]) {
    return [false, false, true];
  }
  if (dataFromDatabse == [PetType.dog]) {
    return [true, false, false];
  }
  if (dataFromDatabse == [PetType.cat]) {
    return [false, true, false];
  }
}
}
