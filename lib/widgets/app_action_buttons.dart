import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

class AppActionButtons extends StatelessWidget {
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final String primaryTextKey;
  final String secondaryTextKey;

  const AppActionButtons({
    Key? key,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    required this.primaryTextKey,
    required this.secondaryTextKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        ElevatedButton(
          onPressed: onPrimaryPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF74C3E9), // Background color
            fixedSize: const Size(320, 65), // Width and height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            appLocalizations.translate(primaryTextKey),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10), // Space between buttons
        TextButton(
          onPressed: onSecondaryPressed,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            fixedSize: const Size(320, 65), // Width and height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            appLocalizations.translate(secondaryTextKey),
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF74C3E9), // Secondary button text color
            ),
          ),
        ),
      ],
    );
  }
}
