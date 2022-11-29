import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/app_image.dart';
import 'package:paw_pals/widgets/buttons/app_button.dart';
import 'package:paw_pals/widgets/list_of_posts.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

/// Builds a generalized profile screen based on an expected userModel.
/// This widget enables refresh on pull down to update the user profile.
class ProfileBuilder extends StatefulWidget {
  /// The user id of the user to show a profile page for.
  final String uid;


  const ProfileBuilder({
    super.key,
    required this.uid,
  });


  @override
  State<ProfileBuilder> createState() => _ProfileBuilderState();

}

class _ProfileBuilderState extends State<ProfileBuilder> {
  String get uid => super.widget.uid;

  late Future<UserModel?> userModelFuture;
  late Future<List<PostModel>?> userPostsFuture;

  Widget buildUserInfo(BuildContext context, UserModel userModel) {

    return Column(children: [
        FieldWrapper(
          child: AppImage(
            imageUrl: userModel.photoUrl,
            width: 128,
            height: 128,
            defaultImage: AppData.defaultProfile,
          ),
        ),
        FieldWrapper(
          child: Text('  ${userModel.username}\n${userModel.first} ${userModel.last}',
        style: const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 24)
          )
        ),
        FormWrapper(children: [
          FieldWrapper(
            child: Visibility(
              visible: FirebaseAuth.instance.currentUser?.uid == uid,
            child: AppButton(
              appButtonType: AppButtonType.outlined,
              label: "Edit Profile",
              onPressed: () => Get.to(const EditProfileScreen()),
            ),
          )
          )
        ]
        ),
        const Divider(),
      ]);
  }

  @override
  void initState() {
    userModelFuture = FirestoreService.getUserById(uid);
    userPostsFuture = FirestoreService.getPostsByUser(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: refresh,
        child:CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
                child: FutureBuilder(
                future: userModelFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildUserInfo(context, snapshot.data!);
                  }
                  return const Center(child: CircularProgressIndicator());
                }),),
            SliverFillRemaining(
                hasScrollBody: true,
                child: FutureBuilder(
                    future: userPostsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListGrid(post: snapshot.data!);
                      }

                      return const Center(child: CircularProgressIndicator());
                    }),
            ),
          ]
      ));
  }

  /// method invoked when the user pulls down to refresh the profile
  Future<void> refresh() async {
    // wait for the data from database before redrawing the widget
    UserModel? userModel = await FirestoreService.getUserById(uid);
    List<PostModel>? userPosts = await FirestoreService.getPostsByUser(uid);
    setState(() {
      userModelFuture = Future.value(userModel);
      userPostsFuture = Future.value(userPosts);
    });
  }
}