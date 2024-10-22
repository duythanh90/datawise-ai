import 'package:datawiseai/utils/logger.dart';
import 'package:datawiseai/widgets/app_action_button.dart';
import 'package:datawiseai/widgets/app_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/app_title.dart'; // Import the AppTitle widget
import '../../widgets/app_text_field.dart'; // Import the AppTextField widget
import '../../localization/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Create login function
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        Logger.debug('Google sign-in canceled');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // This will return the current Firebase user (after Google authentication)
      final User? firebaseUser = userCredential.user;

      // Check if the Firebase user exists
      if (firebaseUser != null) {
        Logger.debug(
            'Successfully signed in with Google. Firebase User: ${firebaseUser.displayName}');
        return firebaseUser;
      } else {
        Logger.debug('Failed to sign in with Google');
        return null;
      }
    } catch (e) {
      Logger.error('Failed to sign in with Google: $e');
      return null;
    }
  }

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
                      signInWithGoogle();
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
                    onPressed: () {},
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
