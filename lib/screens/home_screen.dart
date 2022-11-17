import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/services/location_services.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/services/auth_service.dart';
import 'package:paw_pals/screens/Feed/feed_screen.dart';
import 'package:paw_pals/screens/login_screen.dart';

/// The app's home screen. User should be directed here if authenticated
/// and the contents should be the app's primary content (in this case a feed).
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build("Home"),
      body: SingleChildScrollView(
        child: FormWrapper(
          children: [
            FieldWrapper(
                child: Text("Our Screens:",
                    style: Theme.of(context).textTheme.headline3)),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const FeedScreen());
                  // The new navigation required for the NavBar
                  // navigate(context, Temp_Home_Screen_Navigators.route_feed_screeen, isRootNavigator: false);
                },
                label: "Feed Example",
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  // returns a OurLocation model won't see anything from it
                  LocationService.getLocation();
                  
                  // currently checks distance from user to dummy data posts
                  // and returns that new list of posts
                  // currently prints information to console
                  LocationService.updatePostListWithSearchRadius(
                        oldPostModelList: AppData.post,
                        userPreferenceModel: FirestoreService.getPreferences());
                },
                label: "Get Location",
                icon: const Icon(Icons.location_on_outlined),
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  // this was a interesting capability didn't know if we wanted
                  // to use it
                  Geolocator.openLocationSettings();
                },
                label: "Go to Location Settings",
                icon: const Icon(Icons.location_searching),
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  AuthService.signOut().then((value) =>
                      Get.offAll(const LoginScreen()));
                },
                label: "Logout",
                icon: AppIcons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
