import 'package:datawiseai/widgets/app_action_button.dart';
import 'package:datawiseai/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_title.dart'; // Import the AppTitle widget
import '../../widgets/app_text_field.dart'; // Import the AppTextField widget
import '../../localization/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/login-bg.png',
              width: screenSize.width + 300, // Set width to screen width
              height: 243, // Fixed height for the image
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 88), // Margin for the title
                  // View
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppTitle(
                        titleKey: appLocalizations.translate('login_title'),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 55), // Space between title and username label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      appLocalizations.translate('username_label'),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          12), // Space between username label and text field
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          12), // Space between password label and text field
                  AppTextField(
                    hintTextKey: appLocalizations.translate('password_hint'),
                    isPassword: true,
                  ),
                  // const Spacer(), // Pushes buttons to the bottom
                  AppActionButton(
                    onPressed: () {
                      // Add login logic here
                    },
                    textKey: 'login_button',
                    buttonHeight: 65,
                    buttonType:
                        ButtonType.primary, // Choose primary or secondary
                  ),
                  const SizedBox(
                      height:
                          20), // Space between the last button and the screen bottom
                  AppTextButton(
                    onPressed: () {
                      // Add login logic here
                    },
                    textKey: 'register_button',
                    textColor: Colors.black87,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Add background image at the bottom
        ],
      ),
    );
  }
}
