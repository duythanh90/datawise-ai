import 'package:flutter/material.dart';

class AnimatedProfileOption extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showTrailing;

  const AnimatedProfileOption({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Card(
          color: Colors.grey[900],
          child: ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(label, style: const TextStyle(color: Colors.white)),
            trailing: showTrailing
                ? const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.white54)
                : null,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
