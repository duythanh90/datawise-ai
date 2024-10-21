import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String titleKey;

  const AppTitle({
    super.key,
    required this.titleKey,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleKey,
      style: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
