// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/widgets/testing/mock_firebase.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/app_button.dart';


void main() {
  //Mock Firebase
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

// Find unlike button on post widget on Liked Post Screen
  testWidgets("Unlike Button on Feed Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: LikedPostScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));

    await tester.pump(const Duration(seconds: 5)); // create widget

    // find unlike button
    var posts = find.byType(CachedNetworkImageProvider); // find by photo
    await tester.tap(posts);
    await tester.pumpAndSettle();
    final unlikeButton = find.byType(AppButton);
    await tester.tap(unlikeButton); //tap unlike button
    await tester.pumpAndSettle();
    expect(find.text("Unlike"), findsAtLeastNWidgets(1));
  }
  );
}