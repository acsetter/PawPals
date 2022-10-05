import 'package:flutter/material.dart';
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
      body: const Center(child: Text("Temporary screen to work on navbar")),
      bottomNavigationBar: null,
    );
  }

  @override
  void dispose() {
    // Cleanup unused resources here
    super.dispose();
  }
}