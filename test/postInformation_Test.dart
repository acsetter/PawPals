import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paw_pals/mockfirebase.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';




void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  final TestWidgetsFlutterBinding binding =
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('OurTextField Finder', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = .5625;
    await tester.pumpWidget(const MaterialApp(home: CreatePostScreen()));
    var ourtextfield = find.byType(Scaffold);
    expect(ourtextfield, findsWidgets);});
  // Tests to write
}







