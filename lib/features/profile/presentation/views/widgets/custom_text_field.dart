import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    this.hintText,
    this.keyboardType,
    this.onChange,
    this.obscre = false,
    this.preIcone,
    this.suffIcon,
    this.maxLines = 1,
    required this.controller,
  });
  final String? hintText;
  final Function(String)? onChange;
  final bool obscre;
  final IconButton? suffIcon;
  final Icon? preIcone;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscre,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required 🧐';
        }
      },
      keyboardType: keyboardType,
      onChanged: onChange,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffIcon,
        prefixIcon: preIcone,
        labelText: hintText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),

        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
