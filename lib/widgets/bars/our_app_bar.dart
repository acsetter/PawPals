import 'package:flutter/material.dart';

///
class OurAppBar {
  OurAppBar._();

  static AppBar build(String title) {
    return AppBar(
      title: Text(title),
    );
  }
}