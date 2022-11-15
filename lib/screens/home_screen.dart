import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:paw_pals/constants/app_data.dart';

import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/screens/post/post_screen.dart';
import 'package:paw_pals/screens/temp_user_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/services/location_services.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';

import 'Feed/feed_screen.dart';

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
                  Get.to(() => TempUserScreen());
                },
                label: "Login Screen",
                icon: AppIcons.login,
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                },
                label: "My Profile",
                icon: AppIcons.user,
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const CreatePostScreen());
                },
                label: "Create Post",
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const LikedPostScreen());
                },
                label: "Liked Posts",
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const PostScreen());
                  // The new navigation required for the NavBar
                  // navigate(context, Temp_Home_Screen_Navigators.route_post_screen, isRootNavigator: false);
                },
                label: "Post Example",
              ),
            ),
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
                icon: Icon(Icons.location_on_outlined),
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
                icon: Icon(Icons.location_searching),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
