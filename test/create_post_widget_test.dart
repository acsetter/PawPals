import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/app_button.dart';


/// Morgan Widget Testing - Create Post
/// Should test a create post by entering valid and invalid text
/// within the text fields and attempt to submit the form.

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Create Post Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: CreatePostScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pumpAndSettle();
    final petNameField = find.ancestor(
        of: find.text("Pet Name"), matching: find.byType(TextFormField));
    final petAgeField = find.ancestor(
        of: find.text("Pet Age"), matching: find.byType(TextFormField));
    final postDescriptionField = find.ancestor(
        of: find.text("Post Description"),
        matching: find.byType(TextFormField));
    final dogCatTypeRadio = find.byWidgetPredicate(
          (widget) => widget is Radio<PetType>,
    );
    final maleFemaleTypeRadio = find.byWidgetPredicate(
          (widget) => widget is Radio<PetGender>,
    );
    final kidPetFriendlyCheckbox = find.byWidgetPredicate(
          (widget) => widget is Checkbox,
    );

    final submitBtn = find.byType(AppButton);

    // Blank form submission:
    await tester.enterText(petNameField, "");
    await tester.enterText(petAgeField, "");
    await tester.enterText(postDescriptionField, "");
    expect(dogCatTypeRadio, findsWidgets);
    expect(maleFemaleTypeRadio, findsWidgets);
    expect(kidPetFriendlyCheckbox, findsWidgets);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("No pet name"), findsNothing,
        reason: "Pet Name was submitted blank.");
    expect(find.text("No post description"), findsNothing,
        reason: "Pet Age was submitted blank.");



    // Invalid pet name submission:
    await tester.enterText(petNameField, "Sweet Pea 1012032");
    await tester.enterText(petAgeField, '12');
    await tester.enterText(postDescriptionField, 'Hi my name is sweet pea.');
    expect(dogCatTypeRadio, findsWidgets);
    expect(maleFemaleTypeRadio, findsWidgets);
    expect(kidPetFriendlyCheckbox, findsWidgets);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("Invalid pet name"), findsNothing,
        reason: "Pet Name field submitted as 'Sweet Pea 1012032'");


    // Invalid pet age submission:
    await tester.enterText(petNameField, "Roger");
    await tester.enterText(petAgeField, 'sprinkles');
    await tester.enterText(postDescriptionField, 'Hi my name is Roger.');
    expect(dogCatTypeRadio, findsWidgets);
    expect(maleFemaleTypeRadio, findsWidgets);
    expect(kidPetFriendlyCheckbox, findsWidgets);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("is not a valid number"), findsNothing,
        reason: "Pet Age field submitted as 'sprinkles'");

  });
}
