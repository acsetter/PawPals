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
  /*final TestWidgetsFlutterBinding binding =
  TestWidgetsFlutterBinding.ensureInitialized();*/

  testWidgets('Loading Screen', (WidgetTester tester) async {
    /*binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = .5625;*/
    // Build our app and trigger a frame.
    //await Firebase.initializeApp();

    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 100));

    var circle = find.byType(Center);
    expect(circle, findsOneWidget);


    /*await tester.pumpWidget(const FeedScreen());
    card = find.byType(StreamBuilder);*/
   // await tester.drag(find.byType(Draggable), Offset(201.0, 0.0));
   // await tester.dragFrom(const Offset(0.0,0.0), const Offset(201.0, 0.0));

    //await tester.pumpAndSettle();
    //expect(find.byType(SnackBarAction), find.text("    Like!"));
    //expect(card, findsWidgets);

  });
  testWidgets('swipe right', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 100));
    // var posts = find.byType(Draggable);
    await tester.dragFrom(const Offset(0.0, 0.0), const Offset(0.0, 201.0));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBarAction), find.text("    Like!"));
    });

  testWidgets('swipe left', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 100));
    // var posts = find.byType(Draggable);
    await tester.dragFrom(const Offset(0.0, 0.0), const Offset(0.0, -201.0));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBarAction), find.text("Dislike"));
  });

  testWidgets('tap post', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: FeedScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pump(const Duration(seconds: 100));
    var posts = find.byType(Draggable);
    var name = find.descendant(of: posts, matching: find.byType(Text));
    await tester.tap(name);
    await tester.pumpAndSettle();
  });

}