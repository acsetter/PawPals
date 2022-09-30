import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget body;

  const ScreenWrapper({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build(""),
      body: body
    );
  }
}