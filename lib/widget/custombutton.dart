import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style,
    this.bColor,
  });

  final String label;
  final VoidCallback onPressed;
  final TextStyle? style;
  final Color? bColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: style ?? TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: bColor ?? Color(0xFF3056D3),
          elevation: 0,
          minimumSize: Size.fromHeight(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
