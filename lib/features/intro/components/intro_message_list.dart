import 'dart:math';
import 'dart:io';
import 'package:datawiseai/features/intro/components/email_login_button.dart';

import '../intro_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/storage_utils.dart';
import 'google_login_button.dart';
import 'apple_login_button.dart';
import 'intro_message_types.dart';

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
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  int _visibleMessageCount = 0;
  bool _isLoading = false;
  bool _nameSubmitted = false;

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
                      return _buildInputField(message);
                    }
                    if (message['type'] == TYPE_BUTTONS) {
                      return _buildLoginButtons(context, IntroScreenProvider());
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
          child: const Text('Typing...'),
        ),
      );

  Widget _buildInputField(Map<String, String> message) => Align(
        alignment: Alignment.centerLeft,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Text(
                  message['title'] ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!_nameSubmitted)
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
                    controller: _nameController,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      hintText: 'Type your name...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () async {
                          if (_nameController.text.trim().isNotEmpty) {
                            final name = _nameController.text.trim();
                            await StorageUtils.saveUserName(name);
                            setState(() {
                              _nameSubmitted = true;
                              _introMessages.add({
                                'sender': SENDER_AI,
                                'text': 'Welcome, $name!',
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
          const SizedBox(height: 8),
          EmailLoginButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextBubble(Map<String, String> message, int index) {
    final isLast = index == _introMessages.length - 1;
    final isFirst = index == 0;
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
                child: Text(
                  'AI',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
