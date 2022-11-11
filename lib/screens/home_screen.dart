import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/screens/dashboard/dashboard_screen.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/screens/post/post_screen.dart';
import 'package:paw_pals/screens/temp_user_screen.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import 'package:paw_pals/widgets/buttons/our_outlined_button.dart';

import '../models/post_model.dart';
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
                    style: Theme.of(context).textTheme.headline3)
            ),
            FieldWrapper(
              child: OurOutlinedButton(
                onPressed: () {
                  Get.to(() => const TempUserScreen());
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
                  PostModel post = PostModel(postId: "0111",uid: "1000" ,postDescription:"Whiskers is looking for a loving home." ,petName: "Whiskers",petAge: 4 ,petGender: PetGender.female,isKidFriendly: true, isPetFriendly: true);
                  Get.to(() => PostScreen(post:post));
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
                  // navigate(context, Temp_Home_Screen_Navigators.route_feed_screen, isRootNavigator: false);
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
