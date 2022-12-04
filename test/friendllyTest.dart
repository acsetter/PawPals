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
import 'package:paw_pals/SavannahFirebase.dart';
import 'package:paw_pals/screens/Feed/feed_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';


void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

// Pet Friendly Text is on Widget
  testWidgets('PetFriendlyFinder', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(), // look on FeedScreen
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 5)); // create widget
    var posts = find.byType(Draggable); // find screen card
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name); // tap on text name
    await tester.pumpAndSettle();
    expect(find.text("Pet Friendly"), findsAtLeastNWidgets(1)); // find at least 1 widget with text "pet friendly"
  });

  // Test if widget with Kid Friendly Text is on Feed Screen
  testWidgets('KidFriendlyFinder', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 5));
    var posts = find.byType(Draggable);
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name);
    await tester.pumpAndSettle();
    expect(find.text("Kid Friendly"), findsAtLeastNWidgets(1)); // find at least 1 widget with text "kid friendly"
  });

  // Test if widget with female gender icon is on Liked Post Screen
  testWidgets('KidFriendlyFinder', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 5));
    var posts = find.byType(Draggable);
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name);
    await tester.pumpAndSettle();
    expect(find.text("Kid Friendly"), findsAtLeastNWidgets(1)); // find at least 1 widget with text "kid friendly"
  });

  testWidgets('tap post', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(Duration(seconds: 100));
    var posts = find.byType(Draggable);
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name);
    await tester.pumpAndSettle();
  });

}
