import 'package:flutter/material.dart';

class BtnSignInButton extends StatelessWidget {
  final Color backgroundColor; // Background color provided by parent widget
  final bool isFilled; // Determines if the button is filled or not
  final VoidCallback onPressed; // Callback for button press

  const BtnSignInButton({
    super.key,
    required this.backgroundColor, // Color of the button
    required this.isFilled, // State of the button (fill or not)
    required this.onPressed, // Function to call on button press
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isFilled
          ? backgroundColor
          : Colors.transparent, // Background color based on state
      shape: const CircleBorder(), // Circular button shape
      elevation: isFilled ? 4 : 0, // Elevation when filled
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 60, // Set the size of the round button
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: backgroundColor, // Border color matches background color
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/images/ic_right_arrow.png', // Right arrow icon
            width: 24,
            height: 24,
            color: isFilled
                ? Colors.white
                : backgroundColor, // Icon color based on fill state
          ),
        ),
      ),
    );
  }
}
