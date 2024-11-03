import 'package:datawiseai/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintTextKey;
  final String text;
  final bool isPassword;
  final Function(String) onChanged;

  const AppTextField({
    super.key,
    required this.text,
    required this.hintTextKey,
    required this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: text),
      onChanged: onChanged,
      obscureText: isPassword,
      style: const TextStyle(
          fontSize: 18, color: Colors.black), // Updated font size to 20
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 18, vertical: 12), // Adjusted for height
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: AppColors.appTextFieldBorderColor, width: 1),
        ),
        hintText: hintTextKey,
      ),
      maxLines: 1,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
    );
  }
}
