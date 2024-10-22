import 'package:datawiseai/features/login/widgets/btn_sign_in.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in_with_apple.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in_with_google.dart';
import 'package:datawiseai/utils/app_colors.dart';
import 'package:datawiseai/utils/app_constants.dart';
import 'package:datawiseai/widgets/app_text_button.dart';
import 'package:datawiseai/widgets/choose_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animate_do/animate_do.dart';
import '../../widgets/app_title.dart';
import '../../widgets/app_text_field.dart';
import '../../localization/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLanguageSelected;

  const LoginScreen({Key? key, required this.onLanguageSelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Control the animation duration
    );
    _controller.forward(); // Start the animation on screen load
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    void _onSignIn(User? user) {
      if (user != null) {
        // Navigator.pushNamed(context, '/home');
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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FadeInUp(
              // Fade-in animation for the form
              duration: const Duration(milliseconds: 800),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    Row(
                      children: [
                        const Spacer(),
                        ChooseLanguage(
                          onLanguageSelected: (Locale language) {
                            // Set the new language
                            widget.onLanguageSelected(language);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 0), // Margin for the title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeInUp(
                          child: AppTitle(
                            titleKey: appLocalizations.translate('login_title'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 55),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        appLocalizations.translate('username_label'),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      hintTextKey: appLocalizations.translate('username_hint'),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        appLocalizations.translate('password_label'),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      hintTextKey: appLocalizations.translate('password_hint'),
                      isPassword: true,
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Text(
                          appLocalizations.translate('login_button'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primaryTextColor),
                        ),
                        const Spacer(),
                        FadeInLeft(
                          // Left to right animation for the login button
                          duration: const Duration(milliseconds: 800),
                          child: BtnSignInButton(
                            backgroundColor: AppColors.signInButtonColor,
                            isFilled: true,
                            onPressed: () {
                              _onSignIn(null);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child:
                              Text('or', style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign in buttons: conditional based on platform
                    if (Theme.of(context).platform == TargetPlatform.iOS) ...[
                      BtnSignInWithApple(onSignIn: _onSignIn),
                      const SizedBox(height: 20),
                      BtnSignInWithGoogle(onSignIn: _onSignIn),
                    ] else ...[
                      BtnSignInWithGoogle(onSignIn: _onSignIn),
                      const SizedBox(height: 20),
                      BtnSignInWithApple(onSignIn: _onSignIn),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: AppTextButton(
          onPressed: () {
            // Navigate to register screen
          },
          textKey: 'register_button',
          textColor: Colors.black87,
        ),
      ),
    );
  }
}
