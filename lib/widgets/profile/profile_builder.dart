import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/screens/profile/edit_profile_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/widgets/app_image.dart';
import 'package:paw_pals/widgets/app_button.dart';
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
  ScrollController scrollController = ScrollController();

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${userModel.first} ${userModel.last}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                )
              )
            ],
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(AppIcons.username.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
          ),
          Text('${userModel.username}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24
              )
          )
        ],
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
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: userModelFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildUserInfo(context, snapshot.data!);
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
            ),
            FutureBuilder(
                future: userPostsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListGrid(posts: snapshot.data!);
                  }
                  return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                }
            ),
          ],
        ),
    );
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