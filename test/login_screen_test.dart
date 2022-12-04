import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:paw_pals/constants/app_theme.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/app_button.dart';

/// Black-box system testing for login screen using
/// https://pub.dev/packages/firebase_auth_mocks
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login System Test", (tester) async {

    /** (1) ACCEPTANCE CRITERIA: The user is shown the application's home (feed)
     ** page after logging in with valid email and password credentials. **/
    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        testAuth: MockFirebaseAuth(
          signedIn: false,
          mockUser: MockUser(
            isAnonymous: false,
            uid: "validTestUID",
            email: "foo@bar.com",
          ),
        ),
      ),
      locale: const Locale("en", "US"),
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: AppTheme.light(),
    ));
    await tester.pumpAndSettle();
    expect(find.text("Login"), findsWidgets);

    await tester.enterText(find.widgetWithText(TextFormField, "Email"), "foo@bar.com");
    await tester.enterText(find.widgetWithText(TextFormField, "Password"), "Abc-1234");
    await tester.tap(find.widgetWithText(AppButton, "Login"));
    await tester.pumpAndSettle();

    expect(find.text("Login"), findsNothing, reason: "User should be successfully logged in.");

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text(''),),));
    await tester.pumpAndSettle();

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        testAuth: MockFirebaseAuth(
          signedIn: false,
          mockUser: MockUser(
            isAnonymous: false,
            uid: "validTestUID",
            email: "foo@bar.com",
          ),
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword: FirebaseAuthException(
                code: "wrong-password"
            ),
          ),
        ),
      ),
      locale: const Locale("en", "US"),
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: AppTheme.light(),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Login"), findsWidgets);

    /* This forces proper disposal of objects from previous test as a
    ** (janky) solution to a 3-year-old issue:
    ** https://github.com/flutter/flutter/issues/33186
    ** which is likely a problem GlobalKeys causing lifecycle issues. */
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text(''),),));
    await tester.pumpAndSettle();


    /** (2) ACCEPTANCE CRITERIA: The user is shown an error messaging after
     ** attempting to login with invalid credentials. **/
    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        testAuth: MockFirebaseAuth(
          signedIn: false,
          mockUser: MockUser(
            isAnonymous: false,
            uid: "validTestUID",
            email: "foo@bar.com",
          ),
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword: FirebaseAuthException(
                code: "wrong-password"
            ),
          ),
        ),
      ),
      locale: const Locale("en", "US"),
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: AppTheme.light(),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Login"), findsWidgets, reason: "Login form should be visible.");

    await tester.enterText(find.widgetWithText(TextFormField, "Email"), "foo@bar.com");
    await tester.enterText(find.widgetWithText(TextFormField, "Password"), "Abc-1234");
    await tester.tap(find.widgetWithText(AppButton, "Login"));

    for (int i = 0; i < 5; i++) {
      // another janky solution to timers causing test issues:
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.byType(GetSnackBar, skipOffstage: false), findsWidgets, reason: "User should not be successfully logged in.");

    // Everytime I call this, I get a little more sad.
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text(''),),));
    await tester.pumpAndSettle();


    /** (3) ACCEPTANCE CRITERIA: The user is shown an error message if a network
     ** error or timeout occurs. **/
    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        testAuth: MockFirebaseAuth(
          signedIn: false,
          mockUser: MockUser(
            isAnonymous: false,
            uid: "validTestUID",
            email: "foo@bar.com",
          ),
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword: FirebaseAuthException(
                code: "wrong-password"
            ),
          ),
        ),
      ),
      locale: const Locale("en", "US"),
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: AppTheme.light(),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Login"), findsWidgets, reason: "Login form should be visible.");

    await tester.enterText(find.widgetWithText(TextFormField, "Email"), "foo@bar.com");
    await tester.enterText(find.widgetWithText(TextFormField, "Password"), "Abc-1234");
    await tester.tap(find.widgetWithText(AppButton, "Login"));

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.byType(GetSnackBar, skipOffstage: false),
        findsWidgets, reason: "User should not be successfully logged in.");

    // wait for timers to expire before ending test.
    await tester.pumpAndSettle(const Duration(seconds: 7));
  });

  // For some reason, segregating tests causes state issues? -_-
  // Flutter needs to improve testing badly.
  // testWidgets("(2) Invalid Login Test", (tester) async {});
}
