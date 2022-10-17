import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_data.dart';
import '../../widgets/bars/our_app_bar.dart';

/// This class will eventually become our home screen once the navbar
/// is working as intended.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build("Dashboard (temp)"),
      body: Center(
        child: Image(
          image: AppData.tabbyCat,
          height: 200,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Cleanup unused resources here
    super.dispose();
  }
}