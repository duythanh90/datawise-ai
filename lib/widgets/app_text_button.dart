import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textKey; // Use localization key for the text
  final Color? textColor; // Optional text color

  const AppTextButton({
    Key? key,
    required this.onPressed,
    required this.textKey, // Localization key instead of direct text
    this.textColor, // Allow optional text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove default padding
        minimumSize: const Size(0, 0), // Remove minimum size constraints
        tapTargetSize:
            MaterialTapTargetSize.shrinkWrap, // Shrink touchable area
        backgroundColor: Colors.transparent, // No background
        splashFactory: NoSplash.splashFactory, // No splash effect
      ),
      child: Text(
        appLocalizations.translate(textKey), // Localized text for button
        style: TextStyle(
          fontSize: 18,
          color: textColor ??
              Theme.of(context)
                  .primaryColor, // Default to primary color if not provided
        ),
      ),
    );
  }
}
