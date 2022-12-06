import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_info.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/pref_model.dart';
import 'package:paw_pals/screens/feed_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';

class PreferenceForm extends StatefulWidget {
  const PreferenceForm({super.key});

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  PetType? _typeSelection;
  PetGender? _genderSelection;
  bool _kidFriendlySelection = false;
  bool _petFriendlySelection = false;
  int _minAgeSelection = AppInfo.minPetAge;
  int _maxAgeSelection = AppInfo.maxPetAge;
  int _searchRadius = 50;

  @override
  void initState() {
    FirestoreService.getPreferences().then((prefModel) {
      setState(() {
        _typeSelection = prefModel?.petType ?? _typeSelection;
        _genderSelection = prefModel?.petGender ?? _genderSelection;
        _kidFriendlySelection =
            prefModel?.isKidFriendly ?? _kidFriendlySelection;
        _petFriendlySelection =
            prefModel?.isPetFriendly ?? _petFriendlySelection;
        _minAgeSelection = prefModel?.minAge ?? _minAgeSelection;
        _maxAgeSelection = prefModel?.maxAge ?? _maxAgeSelection;
        _searchRadius = prefModel?.searchRadius ?? _searchRadius;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                value: PetType.dog,
                groupValue: _typeSelection,
                onChanged: ((PetType? value) {
                  if (_typeSelection != null && value == null) {
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
                  if (_typeSelection != null && value == null) {
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
                  if (_genderSelection != null && value == null) {
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
                  if (_genderSelection != null && value == null) {
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
                  }),
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
            Text("$_minAgeSelection"),
            RangeSlider(
              values: RangeValues(
                  _minAgeSelection.toDouble(), _maxAgeSelection.toDouble()),
              max: AppInfo.maxPetAge.toDouble(),
              min: AppInfo.minPetAge.toDouble(),
              divisions: AppInfo.maxPetAge - AppInfo.minPetAge,
              onChanged: (RangeValues values) {
                setState(() {
                  _minAgeSelection = values.start.toInt();
                  _maxAgeSelection = values.end.toInt();
                });
              },
            ),
            Text("$_maxAgeSelection")
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
              value: _searchRadius.toDouble(),
              max: AppInfo.maxSearchRadius.toDouble(),
              min: AppInfo.minSearchRadius.toDouble(),
              divisions: AppInfo.maxSearchRadius - AppInfo.minSearchRadius,
              onChanged: (value) {
                setState(() {
                  _searchRadius = value.toInt();
                });
              },
            ),
            Text("$_searchRadius mi")
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
                  FirestoreService.updatePreferences(PreferencesModel(
                          petType: _typeSelection,
                          petGender: _genderSelection,
                          minAge: _minAgeSelection,
                          maxAge: _maxAgeSelection,
                          searchRadius: _searchRadius,
                          isPetFriendly: _petFriendlySelection,
                          isKidFriendly: _kidFriendlySelection))
                      .then((val) {
                    Get.offAll(() => const FeedScreen());
                  });
                },
                child: const Text("Save"))
          ],
        )
      ],
    ));
  }
}
