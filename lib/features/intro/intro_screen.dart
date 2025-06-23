import 'package:datawiseai/features/intro/intro_message_list.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212), // Same dark color
        elevation: 0,
        title: const Text(
          'Datawise AI',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // back button color if any
      ),
      body: const SafeArea(
        child: IntroMessageList(),
      ),
    );
  }
}
