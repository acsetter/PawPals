import 'package:flutter/material.dart';

/// A widget that wraps a form to provide uniform style and structure
/// throughout the app.
class FormWrapper extends StatelessWidget {
  final List<Widget> children;

  const FormWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children
        ),
      )
    );
  }
}
