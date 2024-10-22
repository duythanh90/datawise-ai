import 'package:datawiseai/localization/app_localizations.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BtnSignInWithGoogle extends StatelessWidget {
  final Function(User?) onSignIn;

  const BtnSignInWithGoogle({
    super.key,
    required this.onSignIn, // Accept a callback function
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          double.infinity, // Make the button take the full width of the screen
      child: ElevatedButton.icon(
        onPressed: () async {
          try {
            // Trigger the Google sign-in flow
            final GoogleSignIn googleSignIn = GoogleSignIn();
            final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

            if (googleUser == null) {
              // If the user cancels the sign-in
              Logger.debug('Google sign-in canceled');
              onSignIn(null);
              return;
            }

            // Obtain Google auth details
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

            // Create a new credential for Firebase using the Google tokens
            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            // Sign in to Firebase with the Google credential
            final UserCredential userCredential =
                await FirebaseAuth.instance.signInWithCredential(credential);

            // Get the Firebase user
            final User? user = userCredential.user;

            if (user != null) {
              Logger.debug('Firebase user: ${user.uid}, ${user.displayName}');
              onSignIn(user); // Trigger the callback with the signed-in user
            } else {
              Logger.error('Failed to sign in with Google.');
              onSignIn(null);
            }
          } catch (e) {
            Logger.error('Error during Google Sign-In: $e');
            onSignIn(null);
          }
        },
        icon: Image.asset(
          'assets/images/google-logo.png', // Google logo image
          width: 20, // Adjust the icon size if needed
          height: 20,
        ),
        label: Text(
          AppLocalizations.of(context)!.translate('sign_in_with_google'),
          style: TextStyle(
            fontSize: 17.8,
            color: Colors.black, // Button text color
          ),
        ),
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFF333333), // Near black border color
            width: 1, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22), // Button border radius
          ),
          padding: const EdgeInsets.symmetric(vertical: 8), // Button height
        ),
      ),
    );
  }
}
