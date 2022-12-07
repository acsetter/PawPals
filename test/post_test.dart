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

// Find post widget on Feed Screen
  testWidgets("Post on Feed Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pump(const Duration(seconds: 5)); // create widget
    find.byType(Draggable); // find screen cards

    //Pet Image on Widget
    final petPhotoFinder = find.byType(CachedNetworkImageProvider);
    expect(petPhotoFinder, findsAtLeastNWidgets(1));

    // Pet Name Text on Widget
    final petNameFinder = find.byType(Text);
    expect(petNameFinder, findsAtLeastNWidgets(1));

    // Pet Age Text on Widget
    final petAgeFinder = find.byType(Text);
    expect(petAgeFinder, findsAtLeastNWidgets(1));


  }
  );
}