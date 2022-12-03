import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:paw_pals/screens/home_screen.dart';
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'package:paw_pals/screens/post/liked_post_screen.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';

import '../../constants/app_icons.dart';
import '../../models/user_model.dart';

class Navbar extends StatefulWidget {
  final String title;
  final Widget child;
  final int navIndex;

  const Navbar({
    super.key,
    child,
    title,
    navIndex,})
      : navIndex = navIndex ?? 0,
        title = title ?? "",
        child = child ?? const Text("Error");

  @override
  State<StatefulWidget> createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  Navbar get _screenWrapper => super.widget;
  Widget get _child => _screenWrapper.child;
  int _index = 0;

  Map<int, Widget> screens = {
    0: const HomeScreen(),
    1: const LikedPostScreen(),
    2: const ProfileScreen(),
    3: const CreatePostScreen()
  };

  static Icon navIcon(IconData iconData) {
    return Icon(iconData);
  }

  @override
  void initState() {
    _index = _screenWrapper.navIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<UserModel?>(
      stream: AppUser.instance.appUserChanges(),
      builder: (BuildContext context, snapshot) {
        return Scaffold(
          body: _child,
          bottomNavigationBar: AppUser.instance.userModel != null ? BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primary,
            selectedItemColor: Colors.white,
            unselectedItemColor: AppColors.primary.shade200,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _index,
            onTap: (index) {
              Get.appUpdate();
              Get.offAll(screens[index], transition: Transition.downToUp);
              _index = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: AppIcons.feed,
                  label: "Feed"
              ),
              BottomNavigationBarItem(
                  icon: AppIcons.likedPostsInactive,
                  activeIcon: AppIcons.likedPostsActive,
                  label: "Liked Posts"
              ),
              BottomNavigationBarItem(
                  icon: AppIcons.myProfileInactive,
                  activeIcon: AppIcons.myProfileActive,
                  label: "Profile"
              ),
              BottomNavigationBarItem(
                  icon: AppIcons.createPostInactive,
                  activeIcon: AppIcons.createPostActive,
                  label: "New Post"
              ),
            ],
          ) : null,
        );
      }
    );
  }
}