import 'dart:math';
import 'dart:io';
import 'package:datawiseai/features/intro/components/email_login_button.dart';
import 'package:datawiseai/widgets/gradient_text.dart';

import 'intro_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/storage_utils.dart';
import 'components/google_login_button.dart';
import 'components/apple_login_button.dart';
import 'components/intro_message_types.dart';

const String TYPE_EMAIL_CONFIRM = 'TYPE_EMAIL_CONFIRM';

class IntroMessageList extends StatefulWidget {
  const IntroMessageList({super.key});

  @override
  State<IntroMessageList> createState() => _IntroMessageListState();
}

class _IntroMessageListState extends State<IntroMessageList> {
  final List<Map<String, String>> _introMessages = [
    {
      'sender': SENDER_AI,
      'text': "👋 Hi there! Ready to make your data work for you? Let's begin!",
      'type': TYPE_TEXT,
    },
    {
      'sender': SENDER_AI,
      'text':
          '📂 First, you can upload your data via a link, PDF, or text file. I’ll keep it safe.',
      'type': TYPE_TEXT,
    },
    {
      'sender': SENDER_AI,
      'text':
          '🤖 Then I’ll turn that data into a smart chatbot that can answer questions.',
      'type': TYPE_TEXT,
    },
    {
      'sender': SENDER_AI,
      'text':
          '🌍 Want to share it? Go ahead! Others can benefit from your chatbot too.',
      'type': TYPE_TEXT,
    },
    {
      'sender': SENDER_AI,
      'text': 'What should I call you? 😊',
      'type': TYPE_TEXT,
    },
    {
      'sender': SENDER_HUMAN,
      'text': 'Tell me your name, and I’ll remember it for our chats.',
      'title': 'Enter your name',
      'type': TYPE_INPUT,
      'field': 'name',
    },
  ];

  int _visibleMessageCount = 0;
  bool _isLoading = false;
  bool _nameSubmitted = false;
  bool _emailSubmitted = false;
  bool _passwordSubmitted = false;

  String? _emailInput;
  String? _passwordInput;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showMessages();
  }

  void _showMessages() async {
    final random = Random();
    for (int i = _visibleMessageCount; i < _introMessages.length; i++) {
      setState(() => _isLoading = true);
      final delay = 500 + random.nextInt(1000);
      await Future.delayed(Duration(milliseconds: delay));
      setState(() {
        _visibleMessageCount++;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IntroScreenProvider>(
      builder: (context, loginProvider, _) {
        return Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _visibleMessageCount + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _visibleMessageCount) {
                      return _buildTypingBubble();
                    }
                    final message = _introMessages[index];
                    if (message['type'] == TYPE_INPUT) {
                      return _buildInputField(message, loginProvider);
                    }
                    if (message['type'] == TYPE_BUTTONS) {
                      return _buildLoginButtons(context, loginProvider);
                    }
                    if (message['type'] == TYPE_EMAIL_CONFIRM) {
                      return _buildEmailConfirm(message);
                    }
                    return _buildTextBubble(message, index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypingBubble() => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const GradientText("Typing...",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )),
        ),
      );

  Widget _buildInputField(
      Map<String, String> message, IntroScreenProvider loginProvider) {
    // Choose controller based on field
    TextEditingController controller;
    String field = message['field'] ?? '';
    if (field == 'name') {
      controller = _nameController;
    } else if (field == 'email') {
      controller = _emailController;
    } else if (field == 'password') {
      controller = _passwordController;
    } else {
      controller = TextEditingController(); // fallback
    }

    // Show condition by field
    bool showInput = (field == 'name' && !_nameSubmitted) ||
        (field == 'email' && !_emailSubmitted) ||
        (field == 'password' && !_passwordSubmitted);

    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              // child: Text(
              //   message['title'] ?? '',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Colors.grey.shade600,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              child: GradientText(
                message['title'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (showInput)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  maxLength: 30,
                  maxLines: 1,
                  obscureText: field == 'password',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: field == 'email'
                        ? 'Type your email...'
                        : field == 'password'
                            ? 'Type your password...'
                            : 'Type your name...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () async {
                        final input = controller.text.trim();
                        if (input.isEmpty) return;

                        if (field == 'name') {
                          await StorageUtils.setUserName(input);
                          setState(() {
                            _nameSubmitted = true;
                            _introMessages.add({
                              'sender': SENDER_AI,
                              'text': 'Welcome, $input!',
                              'type': TYPE_TEXT,
                            });
                            _introMessages.add({
                              'sender': SENDER_AI,
                              'text': 'Now please log in to continue. 😊',
                              'type': TYPE_TEXT,
                            });
                            _introMessages.add({
                              'sender': SENDER_AI,
                              'type': TYPE_BUTTONS,
                            });
                          });
                          controller.clear();
                          _showMessages();
                        } else if (field == 'email') {
                          final emailRegex = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
                          if (!emailRegex.hasMatch(input)) {
                            setState(() {
                              _emailSubmitted = false;
                              _introMessages.removeWhere((msg) =>
                                  msg['type'] == TYPE_INPUT &&
                                  msg['field'] == 'email');
                              _introMessages.add({
                                'sender': SENDER_AI,
                                'text':
                                    "That email doesn't look correct. Please try again.",
                                'type': TYPE_TEXT,
                              });
                              _introMessages.add({
                                'sender': SENDER_HUMAN,
                                'title': 'Enter your email',
                                'type': TYPE_INPUT,
                                'field': 'email',
                              });
                            });
                            controller.clear();
                            _showMessages();
                            return;
                          }
                          _emailInput = input;
                          _emailSubmitted = true;
                          setState(() {
                            _introMessages.removeWhere((msg) =>
                                msg['type'] == TYPE_INPUT &&
                                msg['field'] == 'email');
                            _introMessages.add({
                              'sender': SENDER_AI,
                              'text': _emailInput!,
                              'type': TYPE_EMAIL_CONFIRM,
                            });
                          });
                          controller.clear();
                          _showMessages();
                        } else if (field == 'password') {
                          _passwordInput = input;
                          loginProvider.setEmail(_emailInput ?? '');
                          loginProvider.setPassword(_passwordInput ?? '');

                          setState(() {
                            _passwordSubmitted = true;
                          });

                          controller.clear();
                          await loginProvider.signInWithEmailAsync(context);
                          _showMessages();
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailConfirm(Map<String, String> message) {
    final email = message['text'] ?? '';
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your email is $email',
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  _emailSubmitted = false;
                  _introMessages.add({
                    'sender': SENDER_HUMAN,
                    'title': 'Enter your email',
                    'type': TYPE_INPUT,
                    'field': 'email',
                  });
                });
                _showMessages();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButtons(
      BuildContext context, IntroScreenProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          if (Platform.isIOS || Platform.isAndroid)
            AppleLoginButton(
              onPressed: () async {
                final user = await loginProvider.signInWithAppleAsync(context);
                // ignore: use_build_context_synchronously
                if (user != null) loginProvider.onSignIn(user, context);
              },
            ),
          const SizedBox(height: 8),
          GoogleLoginButton(
            onPressed: () async {
              final user = await loginProvider.signInWithGoogleAsync(context);
              // ignore: use_build_context_synchronously
              if (user != null) loginProvider.onSignIn(user, context);
            },
          ),
          // const SizedBox(height: 8),
          // EmailLoginButton(
          //   onPressed: () {
          //     setState(() {
          //       _introMessages.add({
          //         'sender': SENDER_HUMAN,
          //         'title': 'Enter your email',
          //         'type': TYPE_INPUT,
          //         'field': 'email',
          //       });
          //     });
          //     _showMessages();
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildTextBubble(Map<String, String> message, int index) {
    const String typeEmailConfirm = 'TYPE_EMAIL_CONFIRM';
    final isLast = index == _introMessages.length - 1;
    final isFirst = index == 0;

    if (message['type'] == typeEmailConfirm) {
      return Align(
        alignment: Alignment.centerLeft,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  "Your email is ${message['text']}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _emailSubmitted = false;
                        _introMessages.removeWhere((msg) =>
                            msg['type'] == TYPE_INPUT &&
                            msg['field'] == 'email');
                        _introMessages.add({
                          'sender': SENDER_HUMAN,
                          'title': 'Enter your email',
                          'type': TYPE_INPUT,
                          'field': 'email',
                        });
                      });
                      _showMessages();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Email',
                        style: TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _passwordSubmitted = false;
                        _introMessages.removeWhere((msg) =>
                            msg['type'] == TYPE_INPUT &&
                            msg['field'] == 'password');
                        _introMessages.add({
                          'sender': SENDER_HUMAN,
                          'title': 'Enter your password',
                          'type': TYPE_INPUT,
                          'field': 'password',
                        });
                      });
                      _showMessages();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Text('Continue', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirst)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: GradientText(
                  'Datawise AI',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: isLast ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                message['text']!,
                style: TextStyle(
                  fontSize: isLast ? 18 : 16,
                  fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                  color: isLast ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
