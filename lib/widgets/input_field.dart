import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.controller,
    this.label,
    this.prefixText,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? label;
  final String? prefixText;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, prefixText: prefixText),
    );
  }
}
