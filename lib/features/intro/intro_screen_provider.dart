import 'package:datawiseai/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:datawiseai/utils/app_colors.dart';
import 'package:datawiseai/utils/storage_utils.dart';

class IntroScreenProvider with ChangeNotifier {
  String _email = '';
  String _password = '';

  String getEmail() => _email;
  void setEmail(String email) => _email = email;

  String getPassword() => _password;
  void setPassword(String password) => _password = password;

  // Email/password login
  Future<void> signInWithEmailAsync(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;

    if (_email.isEmpty || _password.isEmpty) {
      _showError(appLocalizations.translate('login_error_empty_fields'));
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      await onSignIn(userCredential.user, context);
    } on FirebaseAuthException catch (e) {
      Logger.error(e.toString());
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              appLocalizations.translate('login_error_user_not_found');
          break;
        case 'wrong-password':
          errorMessage =
              appLocalizations.translate('login_error_wrong_password');
          break;
        default:
          errorMessage = appLocalizations.translate('login_error_generic');
          break;
      }

      _showError(errorMessage);
    } catch (e) {
      Logger.error("Unexpected error: $e");
      _showError(appLocalizations.translate('login_error_generic'));
    }
  }

  // Google Sign-In
  Future<User?> signInWithGoogleAsync(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await onSignIn(userCredential.user, context);
      return userCredential.user;
    } catch (e) {
      Logger.error("Google Sign-In error: $e");
      _showError("Google sign-in failed.");
      return null;
    }
  }

  // Apple Sign-In
  Future<User?> signInWithAppleAsync(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      await onSignIn(userCredential.user, context);
      return userCredential.user;
    } catch (e) {
      Logger.error("Apple Sign-In error: $e");
      _showError("Apple sign-in failed.");
      return null;
    }
  }

  // Final navigation logic
  Future<void> onSignIn(User? user, BuildContext context) async {
    if (user != null) {
      final idToken = await user.getIdToken();
      Logger.debug("User signed in: ${user.email ?? user.uid}");
      await StorageUtils.setUserToken(idToken!);

      // Navigate and clear the navigation stack
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      _showError("Authentication failed.");
    }
  }

  void _showError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.toastErrorColor,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
