import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_colors.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart'; // profile
import 'package:paw_pals/screens/home_screen.dart'; // Feed
import 'package:paw_pals/screens/post/liked_post_screen.dart';// liked posts
import 'package:paw_pals/screens/post/create_post_screen.dart';// new post



class OurNavBar extends StatefulWidget {
  const OurNavBar({super.key});

  @override
  State<OurNavBar> createState() => _OurNavBarState();
}

class _OurNavBarState extends State<OurNavBar> {

  int _currentIndex = 0;
  _getScreenItem(int pos) {
    switch (pos) {
      case 0:
        return  const HomeScreen(); // feed
      case 1:
        return const LikedPostScreen(); // liked posts
      case 2:
        return const ProfileScreen(); // profile
      case 3:
        return const CreatePostScreen(); // new post
      default:
        return const Text("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.primaryAccent,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        backgroundColor: AppColors.primary,
        unselectedFontSize: 10,
        
        
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      currentIndex: _currentIndex,
      items: const [


        BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Liked Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'New Post',

          ),
    ],
    ),body: _getScreenItem(_currentIndex),
    );
  }
}
