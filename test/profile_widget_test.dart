import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/app_image.dart';
import 'package:paw_pals/widgets/list_of_posts.dart';


/// Morgan Widget Testing - Profile Screen
/// Should simply find defined widgets on the profile screen.

void main() {


  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets("Profile Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: ProfileScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    final profilePhotoFinder = find.descendant(
        of: find.byType(AppImage), matching: find.byType(Column));
    expect(profilePhotoFinder, findsWidgets);

    final usernameFirstLastFinder = find.byType(Text);
    expect(usernameFirstLastFinder, findsWidgets);

    final profilePostsFinder = find.byType(ListGrid);
    expect(profilePostsFinder, findsOneWidget);
  }
  );
}
