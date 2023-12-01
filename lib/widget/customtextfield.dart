// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.readOnly,
    this.obscureText,
    this.suffixIcon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool? readOnly;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.labelTextField,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText ?? false,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              filled: true,
              fillColor: Color(0xFF3F5F6)),
        )
      ],
    );
  }
}
