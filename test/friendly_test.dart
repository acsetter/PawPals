// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';
import 'package:paw_pals/screens/feed_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';


void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  // find friendly text labels on post
  testWidgets('FriendlyFinder', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(), // look on FeedScreen
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pump(const Duration(seconds: 5)); // create widget
    var posts = find.byType(Draggable); // find screen card
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name); // tap on text name
    await tester.pumpAndSettle();

    // Pet Friendly Text is on Widget
    final petFriendlyFinder = find.text("Pet Friendly");
    expect(petFriendlyFinder, findsAtLeastNWidgets(1)); // find at least 1 widget with text "pet friendly"

    // Kid Friendly Text is on Widget
    final kidFriendlyFinder = find.text("Kid Friendly");
    expect(kidFriendlyFinder, findsAtLeastNWidgets(1)); // find at least 1 widget with text "kid friendly"
  });
}