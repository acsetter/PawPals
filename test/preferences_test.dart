import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/forms/preference_form.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';

/// Johnathan Widget Testing - Preferences Testing
/// This should test the Preferences to make sure it is
/// changing and saving approriately.

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Preferences Tests", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: Scaffold(
        body: PreferenceForm(),
      ),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pumpAndSettle();
    // Testing portion for pet type radio buttons
    final petTypeSelections =
        find.byWidgetPredicate((widget) => widget is Radio<PetType>);
    final petTypeDogSelection = petTypeSelections.first;
    final petTypeCatSelection = petTypeSelections.last;

    // Initalized is both are unselected
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // Cat clicked so cat is selected
    await tester.tap(petTypeCatSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // Cat clicked Once again so cat is unselected
    await tester.tap(petTypeCatSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // Dog clicked so dog is selected
    await tester.tap(petTypeDogSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    // Dog clicked again so dog is unselected
    await tester.tap(petTypeDogSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // When cat is selected and then dog is selected should unslected cat
    await tester.tap(petTypeCatSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    await tester.tap(petTypeDogSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    // When dog is selected and then cat is selected should unslected dog
    await tester.tap(petTypeCatSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petTypeCatSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petTypeDogSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);

    // Testing portion for pet gender radio buttons
    final petGenderSelections =
        find.byWidgetPredicate((widget) => widget is Radio<PetGender>);
    final petGenderMaleSelection = petGenderSelections.first;
    final petGenderFemaleSelection = petGenderSelections.last;

    // Initalized is both are unselected
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when male is clicked male selcted
    await tester.tap(petGenderMaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when male is clicked again it is unselected
    await tester.tap(petGenderMaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when female is clicked female is selected
    await tester.tap(petGenderFemaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    // when female is clciked again female is unslected
    await tester.tap(petGenderFemaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when male is selected after female has been selected female is unselected and male is selected
    await tester.tap(petGenderFemaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    await tester.tap(petGenderMaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when female is selcted after male has been selected male is unslected and female is selected
    await tester.tap(petGenderFemaleSelection);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(petGenderMaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petGenderFemaleSelection)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);

    // Testing portion for friedliness checkboxes
    final kidPetFriendlyCheckbox =
        find.byWidgetPredicate((widget) => widget is Checkbox);
    final kidFriendCheckbox = kidPetFriendlyCheckbox.first;
    final petFriendCheckbox = kidPetFriendlyCheckbox.last;

    // Initalized is both are unselected
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // When kid friendly is clicked kid friendly is selected
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when kid friendly is clicked again it is unselected
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // when pet friendly is clicked pet friendly is selected
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    // when pet friendly is clicked again it is unselected
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // When both are clicked both are selected
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    // When both are clicked again they are unselected
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    // When both are selected and then only one is unselected
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    await tester.tap(petFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);
    await tester.tap(kidFriendCheckbox);
    await tester.pumpAndSettle();
    expect(
        tester
            .getSemantics(kidFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        false);
    expect(
        tester
            .getSemantics(petFriendCheckbox)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        true);

    //Testing portion for age range slider
    final ageSlider = find.byWidgetPredicate((widget) => widget is RangeSlider);

    expect(ageSlider, findsOneWidget);
    // text boxes on each side of slider that display its values
    final rightTextField = find.byType(Text).at(11);
    final leftTextField = find.byType(Text).at(10);

    // initializes with 0 as the minimum and 50 as the maximum
    expect(tester.getSemantics(leftTextField).getSemanticsData().label, '0');
    expect(tester.getSemantics(rightTextField).getSemanticsData().label, '50');

    // Testing portion for radius Slider

    final radiusSlider = find.byWidgetPredicate((widget) => widget is Slider);

    expect(radiusSlider, findsOneWidget);

    final radiusTextField = find.byType(Text).at(13);
    // initializes with 50 mi
    expect(
        tester.getSemantics(radiusTextField).getSemanticsData().label, '50 mi');

    // tapping the center to increase the slider
    await tester.tap(radiusSlider);
    await tester.pumpAndSettle();
    expect(
        tester.getSemantics(radiusTextField).getSemanticsData().label, '78 mi');

    // Test for button
    final saveButton = find.byType(ElevatedButton);
    expect(saveButton, findsOneWidget);
  });
}
