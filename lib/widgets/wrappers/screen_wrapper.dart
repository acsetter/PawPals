import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

class ScreenWrapper extends StatelessWidget {
  final String title;
  final int navbarIndex;
  final Widget body;

  const ScreenWrapper({
    super.key,
    required this.title,
    required this.body,
    navbarIndex}) : navbarIndex = navbarIndex ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build(title),
      body: body,
    );
  }
}