import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paw_pals/constants/app_theme.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/pref_model.dart';
import 'package:paw_pals/models/user_model.dart';
import 'package:paw_pals/screens/home_screen.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/services/firestore_service.dart';
import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/wrappers/auth_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/navbar.dart';
import 'package:paw_pals/Blocks/swipe_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw_pals/constants/app_data.dart';

/// Root of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<PostModel>? postModelList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPosts();
  }

  void _getPosts() async {
    UserModel? userModel = await FirestoreService.getUser();

    PreferencesModel? preferencesModel = await FirestoreService.getPreferences();
    preferencesModel ??= PreferencesModel();
    //List<PostModel>? likedPosts = await FirestoreService.likedPostsByUser(userModel!);

    List<PostModel>? list = await FirestoreService.getFeedPosts(PreferencesModel());
    list ??= AppData.post;
    list.add(AppData.post[0]);
    list.add(AppData.post[1]);
    for(var i =0; i< list.length; i++){
      if (list[i].uid == userModel?.uid){
        list.removeAt(i);
      }
    }

    postModelList = list;
  }
  
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(providers: [
        BlocProvider(create: (_) => SwipeBlock()..add(LoadPosts(posts: postModelList!)))
      ],child:
      GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      // home: const AuthWrapper(
      //     home: HomeScreen(),
      //     login: LoginScreen()),
      home: const AuthWrapper(home: HomeScreen(), login: LoginScreen()),
      locale: const Locale("en", "US"),
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
                builder: (context) => Navbar(child: child)
            )
          ],
        );
      },
      localizationsDelegates: const [
        AppLocalizations.delegate
      ],
      theme: AppTheme.light()
    ),
      );
  }
}
