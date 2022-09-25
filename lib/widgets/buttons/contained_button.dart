import 'package:flutter/material.dart';

typedef Func = void Function();
/// A material-button of highest emphasis used for the main action(s) on the screen.
/// See: https://material.io/components/buttons/flutter
class ContainedButton extends StatelessWidget {
  final String label;
  final Func onPressed;
  final Icon? icon;

  const ContainedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16.0)
      ),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        label: Text(label),
        icon: icon ?? const Icon(Icons.question_mark),
      );
    }

    return ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label)
    );
  }
}