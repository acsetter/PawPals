import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/app_button.dart';


/// Morgan Widget Testing - Edit Profile
/// Should find widgets on the edit profile screen and attempt
/// to enter both valid and invalid text and submit the form.

void main() {

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });



  testWidgets("Edit Profile Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: EditProfileScreen(),
      localizationsDelegates: [AppLocalizations.delegate],

    ));

    final firstNameField = find.ancestor(of: find.text("First Name"), matching: find.byType(TextFormField));
    final lastNameField = find.ancestor(of: find.text("Last Name"), matching: find.byType(TextFormField));
    final submitBtn = find.byType(AppButton);

    // Blank form submission:
    await tester.enterText(firstNameField, "");
    await tester.pumpAndSettle();
    await tester.enterText(lastNameField, "");
    await tester.pumpAndSettle();
    await tester.tap(submitBtn);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Please enter your first name."), findsWidgets,
        reason: "First name field was submitted blank.");
    expect(find.text("Please enter your last name."), findsWidgets,
        reason: "Last name field was submitted blank.");


    // Invalid first name submission:
    await tester.enterText(firstNameField, "3420.39");
    await tester.pumpAndSettle();
    await tester.enterText(lastNameField, "Glisson");
    await tester.pumpAndSettle();
    await tester.tap(submitBtn);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Name must only contain letters: A-z."), findsWidgets,
        reason: "First name field submitted as '3420.39'");

    // Invalid last name submission:
    await tester.enterText(firstNameField, "Morgan");
    await tester.pumpAndSettle();
    await tester.enterText(lastNameField, "3420.39");
    await tester.pumpAndSettle();
    await tester.tap(submitBtn);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Name must only contain letters: A-z."), findsWidgets,
        reason: "First name field submitted as '3420.39'");

    // Valid first and last name submission:
    await tester.enterText(firstNameField, "Morgan");
    await tester.pumpAndSettle();
    await tester.enterText(lastNameField, "Glisson");
    await tester.pumpAndSettle();
    await tester.tap(submitBtn);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));   });
}