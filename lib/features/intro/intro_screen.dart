import 'package:datawiseai/features/intro/components/intro_message_list.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: IntroMessageList(),
      ),
    );
  }
}
