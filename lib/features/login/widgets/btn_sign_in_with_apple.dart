import 'package:datawiseai/localization/app_localizations.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BtnSignInWithApple extends StatelessWidget {
  final Function(User?) onSignIn;

  const BtnSignInWithApple({
    super.key,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      text: AppLocalizations.of(context)!.translate('sign_in_with_apple'),
      style: SignInWithAppleButtonStyle.whiteOutlined,
      borderRadius: BorderRadius.all(Radius.circular(22)),
      onPressed: () async {
        try {
          // Request Apple ID credential
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

          Logger.debug('Apple ID Credential: $credential');

          // Now authenticate with Firebase using OAuthProvider for Apple
          final OAuthProvider oAuthProvider = OAuthProvider('apple.com');

          final AuthCredential firebaseCredential = oAuthProvider.credential(
            idToken: credential.identityToken,
            accessToken: credential.authorizationCode,
          );

          // Sign in to Firebase with the Apple credential
          final UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(firebaseCredential);

          // Check if the user is signed in successfully
          final User? user = userCredential.user;

          if (user != null) {
            Logger.debug('Firebase user: ${user.uid}, ${user.displayName}');
            onSignIn(user); // Trigger the callback with the signed-in user
          } else {
            Logger.error('Failed to sign in with Apple.');
            onSignIn(null);
          }
        } catch (e) {
          Logger.error('Error during Apple Sign-In: $e');
          onSignIn(null);
        }
      },
    );
  }
}
