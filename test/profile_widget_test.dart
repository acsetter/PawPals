import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/buttons/contained_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/buttons/contained_button.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Profile Screen Test", (tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: ProfileScreen(),
      localizationsDelegates: [AppLocalizations.delegate],
    ));
    await tester.pumpAndSettle();


  });
}