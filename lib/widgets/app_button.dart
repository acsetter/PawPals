import 'package:flutter/material.dart';

typedef Func = void Function();

enum AppButtonType {
  contained,
  outlined,
  text
}

/// A material-button used throughout the app styled based on [AppButtonType].
/// See: https://material.io/components/buttons/flutter
class AppButton extends StatelessWidget {
  final Icon? icon;
  final String label;
  final Func onPressed;
  final AppButtonType appButtonType;
  final ButtonStyle? style;

  const AppButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    required this.appButtonType,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnStyle = ButtonStyle(
      side: appButtonType == AppButtonType.outlined
          ? MaterialStateProperty.all(
              // make the button outline thicker
              BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0))
          : null,
      padding: style?.padding ?? MaterialStateProperty.all(
        // make the button vertically larger
          EdgeInsets.symmetric(
              vertical: icon == null ? 18 : 14
          )
      ),
    ).merge(style);

    if (icon != null) {
      switch (appButtonType) {
        case AppButtonType.contained:
          return ElevatedButton.icon(
            onPressed: onPressed,
            style: btnStyle,
            label: Text(label),
            icon: icon ?? const Icon(Icons.question_mark),
          );
        case AppButtonType.outlined:
          return OutlinedButton.icon(
            onPressed: onPressed,
            style: btnStyle,
            label: Text(label),
            icon: icon ?? const Icon(Icons.question_mark),
          );
        case AppButtonType.text:
          return TextButton.icon(
            onPressed: onPressed,
            style: btnStyle,
            icon: icon ?? const Icon(Icons.question_mark),
            label: Text(label));
      }
    }

    switch (appButtonType) {
      case AppButtonType.contained:
        return ElevatedButton(
          onPressed: onPressed,
          style: btnStyle,
          child: Text(label),
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: btnStyle,
          child: Text(label),
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: btnStyle,
          child: Text(label));
    }
  }
}