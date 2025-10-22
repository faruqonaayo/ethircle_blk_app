import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.prefixText,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? prefixText;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLines;
  final String? Function(String? value)? validator;
  final void Function(String? newValue)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, prefixText: prefixText),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
