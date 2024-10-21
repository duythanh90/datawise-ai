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
      style: const TextStyle(
          fontSize: 20, color: Colors.black), // Updated font size to 20
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // Adjusted for height
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Color(0xFF979797)), // Updated border color to #979797
        ),
        hintText: hintTextKey,
      ),
      maxLines: 1,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
    );
  }
}
