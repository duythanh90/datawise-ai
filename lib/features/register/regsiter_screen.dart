import 'package:datawiseai/features/login/login_provider.dart';
import 'package:datawiseai/features/login/widgets/btn_sign_in.dart';
import 'package:datawiseai/features/register/register_provider.dart';
import 'package:datawiseai/widgets/app_text_button.dart';
import 'package:datawiseai/widgets/app_text_field.dart';
import 'package:datawiseai/widgets/app_title.dart';
import 'package:datawiseai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../localization/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _acceptPolicy = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    var registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    registerProvider.registerUser(context);
  }

  void _showPrivacyPolicyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Privacy & Policy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      'Your Privacy & Policy content goes here...',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  textKey: 'close_button',
                  textColor: Colors.black87,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    var registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    var registerProviderListenr =
        Provider.of<RegisterProvider>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
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
                height: MediaQuery.of(context).size.height,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 88),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeInUp(
                              child: AppTitle(
                                titleKey: appLocalizations
                                    .translate('create_account_title'),
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
                          text: registerProviderListenr.getEmail(),
                          hintTextKey: appLocalizations.translate('email_hint'),
                          onChanged: (String email) {
                            registerProviderListenr.setEmail(email);
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
                          text: registerProviderListenr.getPassword(),
                          hintTextKey:
                              appLocalizations.translate('password_hint'),
                          isPassword: true,
                          onChanged: (String password) {
                            registerProviderListenr.setPassword(password);
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptPolicy,
                              onChanged: (bool? value) {
                                setState(() {
                                  _acceptPolicy = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _acceptPolicy = !_acceptPolicy;
                                  });
                                },
                                child: Text(
                                  appLocalizations
                                      .translate('accept_privacy_policy'),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextButton(
                              onPressed: () {
                                _showPrivacyPolicyModal(context);
                              },
                              textKey: 'show_privacy_policy_button',
                              textColor: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            Text(
                              appLocalizations
                                  .translate('create_account_button'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primaryTextColor,
                              ),
                            ),
                            const Spacer(),
                            FadeInLeft(
                              duration: const Duration(milliseconds: 800),
                              child: BtnSignInButton(
                                backgroundColor: AppColors.signInButtonColor,
                                isFilled: _acceptPolicy,
                                onPressed: () => {
                                  _onRegisterPressed(context),
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Bottom navigation
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textKey: 'login_button',
                          textColor: Colors.black87,
                        ),
                        AppTextButton(
                          onPressed: () {
                            // Navigate to forgot password
                          },
                          textKey: 'forgot_password_button',
                          textColor: Colors.black87,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
