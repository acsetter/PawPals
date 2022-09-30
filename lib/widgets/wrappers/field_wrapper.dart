import 'package:flutter/cupertino.dart';

/// Adds padding to each field/element in a form.
class FieldWrapper extends StatelessWidget {
  final Widget child;

  const FieldWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: child,
    );
  }
}
