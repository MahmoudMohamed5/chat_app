import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.onPressed,
    required this.hintText,
    this.onChanged,
    this.icon,
  });
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool obscureText;
  final String hintText;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if ( value!.isEmpty) {
          return 'required field';
        }
        return null;
      },
      onChanged: onChanged,
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
