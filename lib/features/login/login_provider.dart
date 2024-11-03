import 'package:datawiseai/localization/app_localizations.dart';
import 'package:datawiseai/utils/app_colors.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider with ChangeNotifier {
  String _email = '';
  String _password = '';

  // Getter for email
  String getEmail() {
    return _email;
  }

  // Setter for email
  void setEmail(String email) {
    _email = email;
  }

  // Getter for password
  String getPassword() {
    return _password;
  }

  // Setter for password
  void setPassword(String password) {
    _password = password;
  }

  // Validate inputs and sign in with Firebase
  Future<void> validateAndSignIn(BuildContext context) async {
    var appLocalizations = AppLocalizations.of(context)!;

    // Basic input validation
    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: appLocalizations.translate('login_error_empty_fields'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.toastErrorColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    try {
      // Firebase Auth email and password sign in
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
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

  // Handle sign in result
  void onSignIn(User? user, BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    if (user != null) {
      // Navigate to home screen or show success message
      Navigator.pushNamed(context, '/home');
    } else {
      Fluttertoast.showToast(
          msg: appLocalizations.translate('login_error'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.toastErrorColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
