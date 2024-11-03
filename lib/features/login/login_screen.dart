import 'package:datawiseai/features/login/login_provider.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in_with_apple.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in_with_google.dart';
import 'package:datawiseai/utils/app_colors.dart';
import 'package:datawiseai/widgets/app_text_button.dart';
import 'package:datawiseai/widgets/choose_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_title.dart';
import '../../widgets/app_text_field.dart';
import '../../localization/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLanguageSelected;

  const LoginScreen({super.key, required this.onLanguageSelected});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void onSignIn(User? user) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.onSignIn(user, context);
  }

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
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var loginProviderListener =
        Provider.of<LoginProvider>(context, listen: true);
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Wrap entire screen with GestureDetector to detect taps
      body: GestureDetector(
        onTap: () {
          // Close the keyboard when tapping outside the TextField
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Background image as a full-screen container
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Ensure it fills the full screen
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
                                titleKey:
                                    appLocalizations.translate('login_title'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 55),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            appLocalizations.translate('email_label'),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          text: loginProviderListener.getEmail(),
                          hintTextKey: appLocalizations.translate('email_hint'),
                          onChanged: (String email) {
                            loginProvider.setEmail(email);
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            appLocalizations.translate('password_label'),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          text: loginProviderListener.getPassword(),
                          hintTextKey:
                              appLocalizations.translate('password_hint'),
                          isPassword: true,
                          onChanged: (String password) {
                            loginProvider.setPassword(password);
                          },
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
                                onPressed: () async {
                                  loginProvider.validateAndSignIn(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  appLocalizations.translate('or_label'),
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Sign in buttons: conditional based on platform
                        if (Theme.of(context).platform ==
                            TargetPlatform.iOS) ...[
                          BtnSignInWithApple(onSignIn: onSignIn),
                          const SizedBox(height: 20),
                          BtnSignInWithGoogle(onSignIn: onSignIn),
                        ] else ...[
                          BtnSignInWithGoogle(onSignIn: onSignIn),
                          const SizedBox(height: 20),
                          BtnSignInWithApple(onSignIn: onSignIn),
                        ],
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextButton(
                              onPressed: () {
                                // Navigate to register screen
                                Navigator.pushNamed(context, '/register');
                              },
                              textKey: 'register_button',
                              textColor: Colors.black87,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
