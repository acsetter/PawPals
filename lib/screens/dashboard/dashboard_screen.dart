import 'package:flutter/material.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/widgets/image_selector.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';

/// This should be deleted end of sprint 4.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  FileController fileController = FileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar.build("Dashboard (temp)"),
      body: Center(
        child: ImageSelector(
          controller: fileController,
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