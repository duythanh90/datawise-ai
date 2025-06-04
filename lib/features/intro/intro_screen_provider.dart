import 'package:datawiseai/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:datawiseai/utils/app_colors.dart';

class IntroScreenProvider with ChangeNotifier {
  String _email = '';
  String _password = '';

  String getEmail() => _email;
  void setEmail(String email) => _email = email;

  String getPassword() => _password;
  void setPassword(String password) => _password = password;

  // Email/password login
  Future<void> validateAndSignIn(BuildContext context) async {
    if (_email.isEmpty || _password.isEmpty) {
      _showError("Email or password cannot be empty.");
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      onSignIn(userCredential.user, context);
    } catch (e) {
      _showError("Login failed: ${e.toString()}");
      Logger.error(e.toString());
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
      return userCredential.user;
    } catch (e) {
      Logger.error("Apple Sign-In error: $e");
      _showError("Apple sign-in failed.");
      return null;
    }
  }

  // Final navigation logic
  void onSignIn(User? user, BuildContext context) {
    if (user != null) {
      Navigator.pushNamed(context, '/home');
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

  void signInWithEmailAsync(
      String? emailInput, String? passwordInput, BuildContext context) async {
    var appLocalizations = AppLocalizations.of(context)!;
    try {
      // Firebase Auth email and password sign in
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      // ignore: use_build_context_synchronously
      onSignIn(userCredential.user, context);
    } on FirebaseAuthException catch (e) {
      Logger.error(e.toString());
      // Handle different error codes and show appropriate messages
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = appLocalizations.translate('login_error_user_not_found');
      } else if (e.code == 'wrong-password') {
        errorMessage = appLocalizations.translate('login_error_wrong_password');
      } else {
        errorMessage = appLocalizations.translate('login_error_generic');
      }

      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.toastErrorColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
