// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';
import 'package:paw_pals/screens/feed_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';


void main() {
  //Mock Firebase
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

// Find detailed post widget on Feed Screen
  testWidgets("Detailed Post Feed Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pump(const Duration(seconds: 5)); // create widget
    var posts = find.byType(Draggable); // find screen cards
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name); // tap name on post
    await tester.pumpAndSettle();

    //Pet Image on Widget
    final petPhotoFinder = find.byType(CachedNetworkImageProvider);
    expect(petPhotoFinder, findsAtLeastNWidgets(1));

    // Pet Name Text on Widget
    final petNameFinder = find.byType(Text);
    expect(petNameFinder, findsAtLeastNWidgets(1));

    // Pet Age Text on Widget
    final petAgeFinder = find.byType(Text);
    expect(petAgeFinder, findsAtLeastNWidgets(1));

    // Female Icon on Widget
    final femalePetFinder = find.byIcon(Icons.female);
    expect(femalePetFinder, findsAtLeastNWidgets(1));

    // Male Icon on Widget
    final malePetFinder = find.byIcon(Icons.male);
    expect(malePetFinder, findsAtLeastNWidgets(1));

    // Pet Description on Widget
    final petDescription = find.byType(Text);
    expect(petDescription, findsAtLeastNWidgets(1));
  }
  );
}