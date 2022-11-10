import 'package:flutter/material.dart';
import 'package:paw_pals/widgets/bars/our_app_bar.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';
import '../../constants/app_data.dart';
import '../../widgets/list_of_posts.dart';

/// This is an example of a simple screen that extends a [StatelessWidget]
/// Yes, technically the screen is a widget, but it's best to treat it like
/// a place to organize widgets.
class LikedPostScreen extends StatelessWidget {
  final String screenTitle = "Liked Posts";
  final String exampleText = "Liked Posts Screen";
  final String buttonLabel = "Next Screen";

  // This is the constructor. All widgets should have a Key key as optional
  // parameter in their constructor. Key is something used by flutter engine
  // at the step of recognizing which widget in a list as changed.
  const LikedPostScreen({super.key});

  // You must call @override on the build method
  @override
  Widget build(BuildContext context) {
    // Every screen will use a scaffold as the outer-most widget.
    return Scaffold(

        appBar: OurAppBar.build(screenTitle),
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
          SliverFillRemaining(
          hasScrollBody: true,
          child: Column(
              children: [
              const Divider(),
              Expanded(
          child: DummyGrid(AppData.post)
          )
        ],
      )
    )
    ]
        )
    );
  }
}