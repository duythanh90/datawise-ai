import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String titleKey;

  const AppTitle({
    Key? key,
    required this.titleKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleKey, // Pass the localized title here
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
