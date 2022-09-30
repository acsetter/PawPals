import 'package:flutter/material.dart';

typedef Func = void Function();
/// A material-button of highest emphasis used for the main action(s) on the screen.
/// See: https://material.io/components/buttons/flutter
class OurOutlinedButton extends StatelessWidget {
  final String label;
  final Func onPressed;
  final Icon? icon;

  const OurOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
      side: MaterialStateProperty.all(
        // make the button outline thicker
        BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0)
      ),
      padding: MaterialStateProperty.all(
        // make the button vertically larger
        EdgeInsets.symmetric(
            vertical: icon == null ? 18 : 14
        )
      ),
    );

    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: style,
        label: Text(label),
        icon: icon ?? const Icon(Icons.question_mark),
      );
    }

    return OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label)
    );
  }
}