import 'package:flutter/material.dart';
import 'dart:math';

const String TYPE_TEXT = 'text';
const String TYPE_INPUT = 'input';
const String TYPE_BUTTONS = 'buttons';
const String SENDER_AI = 'AI';
const String SENDER_HUMAN = 'HUMAN';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
      setState(() {
        _isLoading = true;
      });
      final delay = 500 + random.nextInt(1000); // 500 to 1500 ms
      await Future.delayed(Duration(milliseconds: delay));
      setState(() {
        _visibleMessageCount++;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _visibleMessageCount + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _visibleMessageCount) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text('Typing...'),
                        ),
                      );
                    }
                    final message = _introMessages[index];

                    if (message['type'] == TYPE_INPUT) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 4.0),
                                child: Text(
                                  message['title'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (!_nameSubmitted) ...[
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
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
                                    onChanged: (_) => setState(() {}),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your name...',
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.send,
                                            color: Colors.blue),
                                        onPressed: () {
                                          if (_nameController.text
                                              .trim()
                                              .isNotEmpty) {
                                            setState(() {
                                              _nameSubmitted = true;
                                              _introMessages.add({
                                                'sender': SENDER_AI,
                                                'text':
                                                    'Welcome, ${_nameController.text.trim()}!',
                                                'type': TYPE_TEXT,
                                              });
                                              _introMessages.add({
                                                'sender': SENDER_AI,
                                                'text':
                                                    'Now please log in to continue. 😊',
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
                            ],
                          ),
                        ),
                      );
                    }
                    if (message['type'] == TYPE_BUTTONS) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle Google login
                              },
                              icon: Icon(Icons.account_circle),
                              label: Text('Login with Google'),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle Facebook login
                              },
                              icon: Icon(Icons.facebook),
                              label: Text('Login with Facebook'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800]),
                            ),
                          ],
                        ),
                      );
                    }
                    final bool isLast = index == _introMessages.length - 1;
                    final bool isFirst = index == 0;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isFirst
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 4.0),
                                    child: Text(
                                      isFirst ? 'AI' : '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
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
                                  fontWeight: isLast
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isLast ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
