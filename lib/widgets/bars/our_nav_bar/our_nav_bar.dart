import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/screens/Feed/feed_screen.dart';
import 'package:paw_pals/screens/Feed/went_left.dart';
import 'package:paw_pals/screens/Feed/went_right.dart';
import 'package:paw_pals/screens/examples/example_screen.dart';
import 'package:paw_pals/screens/examples/example_stack_screen.dart';
import 'package:paw_pals/screens/post/post_screen.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart'; // profile
import 'package:paw_pals/screens/home_screen.dart'; // Feed
import 'package:paw_pals/screens/post/liked_post_screen.dart';// liked posts
import 'package:paw_pals/screens/post/create_post_screen.dart';
import 'nav_routes.dart';// new post


/// 
/// OurNavBar is a class used for the bar at the bottom of the screen for
/// navigation to the main four screens (Feed, Liked Posts, Profile, and New Post).
/// This class isnt called on every screen like a AppBar is but everything is 
/// navigated through it. It holds the root navigations in which pages are created 
/// from. I found this type of structure and package from
/// https://pub.dev/packages/navbar_router
/// 
class OurNavBar extends StatelessWidget {
  OurNavBar({Key? key}) : super(key: key);

  List<NavbarItem> items = [
    NavbarItem(AppIcons.feedIconData, 'Feed',),
    NavbarItem(AppIcons.likedPostsIconData, 'Liked Posts',),
    NavbarItem(AppIcons.profileIconData, 'Profile',),
    NavbarItem(AppIcons.newPostIconData, 'New Post',),
  ];

  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': HomeScreen(),
      Temp_Home_Screen_Navigators.route_create_post: CreatePostScreen(),
      Temp_Home_Screen_Navigators.route_edit_profile: EditProfileScreen(),
      Temp_Home_Screen_Navigators.route_example_Screen: ExampleScreen(),
      Temp_Home_Screen_Navigators.route_liked_post: LikedPostScreen(),
      Temp_Home_Screen_Navigators.route_my_profile: ProfileScreen(),
      Temp_Home_Screen_Navigators.route_post_screen: PostScreen(),
      Temp_Home_Screen_Navigators.route_feed_screeen: FeedScreen(),
      Temp_Home_Screen_Navigators.route_left: LeftScreen(),
      Temp_Home_Screen_Navigators.route_right: RightScreen(),
      Temp_Home_Screen_Navigators.route_example_stack_screen: ExampleStackScreen(),
  
    },
    1: {
      '/': LikedPostScreen(),
      Liked_Post_Screen_Navigators.route_post_screen: PostScreen(),
      // Liked_Post_Screen_Navigators.route_poster_profile: PosterScreen(), 
    },
    2: {
      '/': ProfileScreen(), 
      Profile_Screen_Navigators.route_edit_profile_screen: EditProfileScreen(),
    },
    3: {
      '/': CreatePostScreen(),
    },
  };

  @override
  Widget build(BuildContext context) {
    return NavbarRouter(
      errorBuilder: (context) {
        return const Center(child: Text('Error 404'));
      },
      onBackButtonPressed: (isExiting) {
        return isExiting;
      },
      destinationAnimationCurve: Curves.fastOutSlowIn,
      destinationAnimationDuration: 1000,
      decoration:
          NavbarDecoration(
            navbarType: BottomNavigationBarType.fixed,
            unselectedItemColor: AppColors.primaryAccent,
            selectedLabelColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Colors.white),
            showUnselectedLabels: true,
            selectedLabelTextStyle: TextStyle(fontSize: 16, color: Colors.white),
            backgroundColor: AppColors.primary,
            unselectedLabelTextStyle: TextStyle(fontSize: 10),
          ),
      destinations: [
        for (int i = 0; i < items.length; i++)
          DestinationRouter(
            navbarItem: items[i],
            destinations: [
              for (int j = 0; j < _routes[i]!.keys.length; j++)
                Destination(
                  route: _routes[i]!.keys.elementAt(j),
                  widget: _routes[i]!.values.elementAt(j),
                ),
            ],
            initialRoute: _routes[i]!.keys.first,
          ),
      ],
    );
  }
}