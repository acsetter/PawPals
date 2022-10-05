import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/screens/dashboard/dashboard_screen.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/screens/post/post_screen.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';
import 'package:paw_pals/widgets/wrappers/screen_wrapper.dart';

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
    return ScreenWrapper(
      title: "Home Screen",
      navbarIndex: 0,
      body: SingleChildScrollView(
        child: FormWrapper(
          children: [
            FieldWrapper(
                child: Text("Our Screens:",
                    style: Theme.of(context).textTheme.headline3)
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                label: "Login Screen",
                icon: AppIcons.login,
              ),
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const DashboardScreen());
                },
                label: "Dashboard (temp)",
                icon: AppIcons.paw,
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
                label: "Posts",
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
          ],
        ),
      ),
    );
  }
}
