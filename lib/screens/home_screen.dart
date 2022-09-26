import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_pals/screens/login_screen.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import '../utils/app_localizations.dart';

/// The app's home screen. User should be directed here if authenticated
/// and the contents should be the app's primary content (in this case a feed).
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("page-titles.home")),
      ),
      body: SafeArea(
        child: FormWrapper(
          children: [
            const Image(
              height: 350,
                image: AssetImage("assets/images/construction-sign.png")
            ),
            FieldWrapper(
              child: Text("The Team:",
                style: Theme.of(context).textTheme.headline3)
            ),
            FieldWrapper(
              child: Table(
                children: const [
                  TableRow(
                      children: [
                        Text("Aaron Csetter")
                      ]
                  ),
                  TableRow(
                      children: [
                        Text("Morgan Glisson")
                      ]
                  ),
                  TableRow(
                    children: [
                      Text("Austin Whittaker")
                    ]
                ],
              )
            ),
            FieldWrapper(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0)
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 18.0)
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => LoginScreen());
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => LoginScreen())
                            // );
                          },
                          child: Text(AppLocalizations.of(context).translate("btn-labels.login"))
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}