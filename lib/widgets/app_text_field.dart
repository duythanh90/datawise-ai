import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintTextKey;
  final bool isPassword;

  const AppTextField({
    Key? key,
    required this.hintTextKey,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintText: hintTextKey, // Pass the localized hint text here
      ),
      maxLines: 1,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
    );
  }
}
