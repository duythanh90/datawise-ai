import 'package:flutter/material.dart';

class AiTipsSection extends StatefulWidget {
  const AiTipsSection({super.key});

  @override
  State<AiTipsSection> createState() => _AiTipsSectionState();
}

class _AiTipsSectionState extends State<AiTipsSection>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _fadeAnimations;
  final List<String> tips = [
    'Keep your data clean and focused for better answers.',
    'Use short questions to get fast, accurate replies.',
    'Train bots with updated documents regularly.',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimations = List.generate(tips.length, (index) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.15, 1.0, curve: Curves.easeOut),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🤖 AI Tips',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(tips.length, (index) {
          return FadeTransition(
            opacity: _fadeAnimations[index],
            child: SlideTransition(
              position: _fadeAnimations[index].drive(
                  Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        color: Colors.amber, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tips[index],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
