import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/buttons/contained_button.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Edit Profile Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: EditProfileScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pumpAndSettle();

    final firstNameField = find.ancestor(of: find.text("First Name"), matching: find.byType(TextFormField));
    final lastNameField = find.ancestor(of: find.text("Last Name"), matching: find.byType(TextFormField));
    final submitBtn = find.byType(ContainedButton);

    // Blank form submission:
    await tester.enterText(firstNameField, "");
    await tester.enterText(lastNameField, "");
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("Please enter your first name."), findsOneWidget, reason: "First name field was submitted blank.");
    expect(find.text("Please enter your last name."), findsOneWidget, reason: "Last name field was submitted blank.");


    // Invalid first name submission:
    await tester.enterText(firstNameField, "3420.39");
    await tester.enterText(lastNameField, "Glisson");
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("Name must only contain letters: A-z."), findsOneWidget, reason: "First name field submitted as '3420.39'");

    // Invalid last name submission:
    await tester.enterText(firstNameField, "Morgan");
    await tester.enterText(lastNameField, "3420.39");
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text("Name must only contain letters: A-z."), findsOneWidget, reason: "First name field submitted as '3420.39'");

    // Valid first and last name submission:
    await tester.enterText(firstNameField, "Morgan");
    await tester.enterText(lastNameField, "Glisson");
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
  });
}