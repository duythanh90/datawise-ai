import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

enum ButtonType {
  primary,
  secondary,
}

class AppActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textKey;
  final ButtonType buttonType;
  final double buttonHeight;

  const AppActionButton({
    Key? key,
    required this.onPressed,
    required this.textKey,
    required this.buttonType,
    this.buttonHeight = 36, // Default button height to 36
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    final ButtonStyle buttonStyle = buttonType == ButtonType.primary
        ? ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF74C3E9), // Primary background
            fixedSize: Size(320, buttonHeight), // Width and dynamic height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          )
        : TextButton.styleFrom(
            backgroundColor: Colors.white, // Secondary background
            fixedSize: Size(320, buttonHeight), // Width and dynamic height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );

    return buttonType == ButtonType.primary
        ? ElevatedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(
              appLocalizations.translate(textKey),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(
              appLocalizations.translate(textKey),
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF74C3E9), // Secondary button text color
              ),
            ),
          );
  }
}
