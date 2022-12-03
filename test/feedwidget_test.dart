// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paw_pals/mockFirebase.dart';
import 'package:paw_pals/my_app.dart';
import 'package:paw_pals/screens/Feed/feed_screen.dart';
import 'package:paw_pals/widgets/screencards.dart';




void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  final TestWidgetsFlutterBinding binding =
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('swipe left', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = .5625;
    // Build our app and trigger a frame.
    //await Firebase.initializeApp();

    await tester.pumpWidget(const FeedScreen());
    var loading = find.byType(Draggable);
    expect(loading,findsOneWidget);




    /*await tester.pumpWidget(const FeedScreen());
    card = find.byType(StreamBuilder);*/
   // await tester.drag(find.byType(Draggable), Offset(201.0, 0.0));
   // await tester.dragFrom(const Offset(0.0,0.0), const Offset(201.0, 0.0));

    //await tester.pumpAndSettle();
    //expect(find.byType(SnackBarAction), find.text("    Like!"));
    //expect(card, findsWidgets);

  });
}