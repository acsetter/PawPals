import 'package:flutter/material.dart';
import 'package:paw_pals/screens/feed_screen.dart';

/// The app's home screen. User should be directed here if authenticated
/// and the contents should be the app's primary content (in this case a feed).
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Redirect instead of refactoring the entire app to point to feed as home.
    return const FeedScreen();
  }

}
