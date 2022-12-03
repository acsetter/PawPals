import 'package:flutter/material.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';

/// Used by [OurTextField.validator].
typedef FormFieldValidator<T> = String? Function(T? value);

/// The styled and featured [TextFormField] used in this app.
class OurTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final FormFieldValidator<String?> validator;
  final Icon? icon;
  final bool hideText;
  final bool? autocorrect;
  final int? maxLength;
  final int? maxLines;
  final bool showCounter;
  final TextInputType? keyboard;
  final List<dynamic>? inputFormatters;
  final String? initialValue;

  const OurTextField({
    super.key,
    required this.labelText,
    required this.validator,
    this.controller,
    this.icon,
    this.autocorrect,
    this.maxLength,
    this.maxLines,
    hideText,
    showCounter,
    this.keyboard,
    this.inputFormatters,
    this.initialValue,
  }): hideText = hideText ?? false,
      showCounter = showCounter ?? false;

  @override
  State<StatefulWidget> createState() => OurTextFieldState();
}

class OurTextFieldState extends State<OurTextField> {
  OurTextField get _textField => super.widget;
  bool isVisible = false;

  InputDecoration fieldDecoration() {
    final InputDecoration base = InputDecoration(
      border: const OutlineInputBorder(),
      labelText: _textField.labelText,
      helperText: "",
      counterText: !_textField.showCounter ? "" : null,
      icon: _textField.icon,
      isDense: false
    );

    // Add an input visibility toggle button when field hides text:
    if (_textField.hideText) {
      return base.copyWith(
        suffixIcon: IconButton(
          icon: isVisible ? AppIcons.visibilityOff : AppIcons.visibility,
          onPressed: () {
            isVisible = !isVisible;
            setState(() {
              // toggle text visibility and redraw
            });
          },
        )
      );
    }

    return base;
  }

  @override
  void initState() {
    isVisible = !_textField.hideText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FieldWrapper(
        child:  TextFormField(
          controller: _textField.controller,
          decoration: fieldDecoration(),
          validator: _textField.validator,
          obscureText: _textField.hideText ? !isVisible : false,
          autocorrect: _textField.autocorrect ?? true,
          maxLength: _textField.maxLength,
          maxLines: _textField.maxLines ?? 1,
          keyboardType:_textField.keyboard,
          inputFormatters: const [],
          initialValue: _textField.initialValue,
        )
    );
  }
}