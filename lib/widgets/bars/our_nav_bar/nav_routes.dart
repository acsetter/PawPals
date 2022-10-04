//**
//These classes are made strictly for convenience. A way to access navgation 
//paths/routes when needed.*/


// Navigation for screens accessed through the profile screen
abstract class Profile_Screen_Navigators {
  static const String route_edit_profile_screen = '/profile_screen/edit_profile_screen';
}

// Navigation for screens accessed through the liked post screen
abstract class Liked_Post_Screen_Navigators {
  static const String route_post_screen = '/liked_post_screen/post_screen';
  static const String route_poster_profile = '/liked_post_screen/post_screen/poster_profile'; // No poster screen yet
}

// Navigation for the buttons currently on our feed/home screen
abstract class Temp_Home_Screen_Navigators {
  static const String route_example_Screen = '/home_screen/example_screen';
  static const String route_my_profile = '/home_screen/profile_screen';
  static const String route_create_post = '/home_screen/create_post_screen';
  static const String route_liked_post = '/home_screen/liked_post_screen';
  static const String route_post_screen = '/home_screen/post_screen';
  static const String route_edit_profile = '/home_screen/profile_screen/edit_profile_screen';
  static const String route_feed_screeen = '/home_screen/feed_screen';
  static const String route_example_stack_screen = 'home_screen/example_screen/example_stack_screen';
  static const String route_left = 'home_screen/feed_screen/went_left';
  static const String route_right = 'home_screen/feed_screen/went_right';
}

// for future home screen navigations
// abstract class Home_Screen_Navigators {
// }