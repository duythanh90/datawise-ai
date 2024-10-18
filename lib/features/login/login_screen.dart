import 'package:flutter/material.dart';
import '../../widgets/app_title.dart'; // Import the AppTitle widget
import '../../widgets/app_text_field.dart'; // Import the AppTextField widget
import '../../widgets/app_action_buttons.dart'; // Import the AppActionButtons widget
import '../../localization/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF75CABB), // Top color
              Color(0xFF2399BB), // Bottom color
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 55), // Margin for the title
              AppTitle(
                titleKey: appLocalizations.translate('login_title'),
              ),
              const SizedBox(
                  height: 55), // Space between title and username label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  appLocalizations.translate('username_label'),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                  height: 12), // Space between username label and text field
              AppTextField(
                hintTextKey: appLocalizations.translate('username_hint'),
              ),
              const SizedBox(
                  height:
                      20), // Space between username field and password label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  appLocalizations.translate('password_label'),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                  height: 12), // Space between password label and text field
              AppTextField(
                hintTextKey: appLocalizations.translate('password_hint'),
                isPassword: true,
              ),
              const Spacer(), // Pushes buttons to the bottom
              AppActionButtons(
                onPrimaryPressed: () {
                  // Add login logic here
                },
                onSecondaryPressed: () {
                  // Add register navigation logic here
                },
                primaryTextKey: 'login_button',
                secondaryTextKey: 'register_button',
              ),
              const SizedBox(
                  height:
                      20), // Space between the last button and the screen bottom
            ],
          ),
        ),
      ),
    );
  }
}
