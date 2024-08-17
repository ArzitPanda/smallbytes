import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';

class TextInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;

  const TextInput({
    Key? key,
    this.placeholder,
    required this.controller,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        labelText: placeholder ?? "Enter your text",
        labelStyle: TextStyle(color: CustomColors.primary),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.grey_border, width: 2),
        ),
      ),
    );
  }
}