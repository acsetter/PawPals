import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/controllers/app_user.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:paw_pals/constants/app_types.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/screens/profile/profile_screen.dart';
import 'package:paw_pals/services/location_services.dart';
import 'package:paw_pals/utils/app_utils.dart';
import 'package:paw_pals/widgets/app_button.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/utils/app_log.dart';

class DetailedPost extends StatelessWidget{
  final PostModel post;

  const DetailedPost({super.key, required this.post});

  Widget buildBadge(BuildContext context, String text, bool isGood) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color(isGood ? 0xFF00C853 : 0xFFFF3D00).withOpacity(0.25)
      ),
      child: Text(text),
    );
  }

  Widget buildBtn(BuildContext context) {
    if (AppUser.instance.userModel?.uid == post.uid) {
      // TODO: Possible add an edit-post and delete-post button
      return const Text(''); 
    }
    
    return AppButton(
      appButtonType: AppButtonType.outlined,
      icon: AppIcons.email,
      label: "Email Owner",
      onPressed: () {
        if (post.email != null) _launchEmail(post.email!);
      },
    );
  }

  Future<void> _launchEmail(String email) async {
    if (await canLaunchUrlString('mailto:$email')) {
      await launchUrlString('mailto:$email');
    } else {
      Logger.log("Error launching email client for $email", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    String uname = post.username ?? "Owner";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          shadows: <Shadow>[
            Shadow(
              blurRadius: 16.0,
              color: Color.fromARGB(150, 0, 0, 0)
            ),
          ],
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(post.petPhotoUrl!),
                        )
                    )
                ),
                Container( // pet name:
                  margin: const EdgeInsets.only(left:10),
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          post.petGender == PetGender.female ? Icons.female : Icons.male,
                          color: Colors.white,
                          size: 36,
                          shadows: const [
                            Shadow(
                                blurRadius: 16.0,
                                color: Color.fromARGB(150, 0, 0, 0)
                            )
                          ],
                        ),
                      ),
                      Text(
                        "${post.petName ?? 'Name Unavailable'}, ${post.petAge}",
                        style: const TextStyle(
                          fontFamily: "Proxima-Nova-Bold",
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          shadows: <Shadow>[
                            Shadow(
                                blurRadius: 16.0,
                                color: Color.fromARGB(150, 0, 0, 0)
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.calendar_month, size: 15),
                  ),
                  Text("Posted ${AppUtils.relDateFromTimestamp(post.timestamp!)} by "),
                  InkWell(
                    child: Text(uname, style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    ),),
                    onTap: () => Get.to(ProfileScreen(uid: post.uid)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.location_on, size: 15),
                  ),
                  FutureBuilder(
                    future: LocationService.getLiveDistance(latB: post.latitude!, longB: post.longitude!),
                    builder: (context, snapshot) => Text("${snapshot.data?.round() ?? '?'} mi away"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                  children: [
                  buildBadge(
                  context,
                  "${post.isPetFriendly ?? false ? '':'Not '}Pet Friendly",
                  post.isPetFriendly ?? false
              ),
              buildBadge(
                  context,
                  "${post.isKidFriendly ?? false ? '':'Not '}Kid Friendly",
                  post.isKidFriendly ?? false
              )],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left:15),
              child: const Text("About Me",
                style: TextStyle(
                  fontFamily: "Proxima-Nova-Bold",
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width*0.85,
              child: Text('${post.postDescription}',
                style: const TextStyle(
                  fontFamily: "ProximaNova-Regular",
                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300
                ),
              ),
            ),
            const Divider(
              color: Colors.white60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: buildBtn(context)
            ),
          ],
        ),
      ),
    );
  }
}