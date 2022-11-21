import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controllers/app_user.dart';
import '../../models/user_model.dart';
import '../../screens/profile/profile_screen.dart';
import '../../services/firestore_service.dart';
import '../profile/profile_builder.dart';
import 'logout_popup.dart';


class OurAppBarProfile {
  OurAppBarProfile._();


  static AppBar build(
      String title,
      BuildContext context,
      ) {
      return AppBar(
        title: Text(title),
        actions: [LogoutAppBarPopup.build(context)],
      );
    }
}