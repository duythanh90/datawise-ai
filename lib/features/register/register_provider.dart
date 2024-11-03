import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  // Setters for email and password
  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }

  // Function to register user to Firebase Auth
  Future<void> registerUser(BuildContext context) async {
    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter email and password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      // Firebase Auth registration using email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // User registration successful
      User? user = userCredential.user;
      if (user != null) {
        Fluttertoast.showToast(
          msg: 'Registration successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Navigate to home or login page after successful registration
        // Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      String message = e.toString();
      int end = message.indexOf(']');
      String errorMessage = message.substring(end + 1, message.length).trim();

      // Handle error cases
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
