import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.validatorFn,
    required this.saveFn,
    this.maxLines = 1,
    this.initialValue,
    this.keyboardType = TextInputType.text,
  });

  final String labelText;
  final String hintText;
  final bool obscureText;
  final String? Function(String? value) validatorFn;
  final void Function(String? value) saveFn;
  final int maxLines;
  final String? initialValue;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1),
        ),
        fillColor: colorScheme.surfaceContainerHigh,
        filled: true,
      ),
      maxLines: maxLines,
      validator: (value) {
        return validatorFn(value);
      },
      onSaved: saveFn,
    );
  }
}
