
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    this.onPressed,
    required this.hintText,
    this.onSubmitted,
    this.icon,
  });
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool obscureText;
  final String hintText;
  final Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(icon)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
