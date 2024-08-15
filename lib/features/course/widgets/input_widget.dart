import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';

class TextInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  TextInput({
    super.key,
    this.placeholder,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.deepOrange.shade50,
        label: Text(
          placeholder ?? "Enter your text",
          style: TextStyle(color: CustomColors.primary),
        ),
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
