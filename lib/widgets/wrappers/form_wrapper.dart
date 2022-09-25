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
        padding: _Styles.formWrapperInsets,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children
        ),
      )
    );
  }
}

class _Styles {
  /// Horizontal padding between a the form and it's parent screen/container.
  static const EdgeInsets formWrapperInsets = EdgeInsets.symmetric(horizontal: 30);
}