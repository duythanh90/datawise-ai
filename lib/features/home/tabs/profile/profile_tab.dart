import 'package:datawiseai/features/home/tabs/profile/widgets/animated_profile_option.dart';
import 'package:datawiseai/features/home/tabs/profile/widgets/token_balance_badge.dart';
import 'package:flutter/material.dart';
import 'package:datawiseai/widgets/gradient_text.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  final String userName = 'John Doe';
  final String userEmail = 'john.doe@example.com';
  final int tokenBalance = 42;

  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    // Create staggered animations for 7 widgets:
    // email, name, avatar, settings, privacy, delete, logout
    _slideAnimations = List.generate(7, (index) {
      final start = 0.05 * index;
      final end = start + 0.3;
      return Tween<Offset>(
        begin: Offset(0, index < 3 ? -0.4 : 0.4),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ));
    });

    _fadeAnimations = List.generate(7, (index) {
      final start = 0.05 * index;
      final end = start + 0.3;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      );
    });

    // Start animation after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(
      String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(onPressed: onConfirm, child: const Text('Confirm')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Avatar
                  SlideTransition(
                    position: _slideAnimations[2],
                    child: FadeTransition(
                      opacity: _fadeAnimations[2],
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              userName[0],
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Open avatar picker
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: const Icon(Icons.edit,
                                    size: 16, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Name
                  SlideTransition(
                    position: _slideAnimations[1],
                    child: FadeTransition(
                      opacity: _fadeAnimations[1],
                      child: GradientText(
                        userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Email
                  SlideTransition(
                    position: _slideAnimations[0],
                    child: FadeTransition(
                      opacity: _fadeAnimations[0],
                      child: Text(
                        userEmail,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey[400]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Reusable AnimatedProfileOptions
                  AnimatedProfileOption(
                    slideAnimation: _slideAnimations[3],
                    fadeAnimation: _fadeAnimations[3],
                    icon: Icons.settings,
                    label: 'Settings',
                    showTrailing: true,
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  ),
                  const SizedBox(height: 8),

                  AnimatedProfileOption(
                    slideAnimation: _slideAnimations[4],
                    fadeAnimation: _fadeAnimations[4],
                    icon: Icons.privacy_tip,
                    label: 'Privacy Policy',
                    onTap: () {
                      // TODO: Open privacy policy
                    },
                  ),
                  const SizedBox(height: 8),

                  AnimatedProfileOption(
                    slideAnimation: _slideAnimations[5],
                    fadeAnimation: _fadeAnimations[5],
                    icon: Icons.delete_forever,
                    label: 'Delete Account',
                    onTap: () {
                      _showConfirmationDialog(
                        'Delete Account',
                        'Are you sure you want to permanently delete your account?',
                        () {
                          Navigator.pop(context);
                          // TODO: Handle deletion
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  AnimatedProfileOption(
                    slideAnimation: _slideAnimations[6],
                    fadeAnimation: _fadeAnimations[6],
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
                      _showConfirmationDialog(
                        'Logout',
                        'Are you sure you want to log out?',
                        () {
                          Navigator.pop(context);
                          // TODO: Handle logout
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // Token Badge (top right corner)
            Positioned(
              top: 16,
              right: 16,
              child: TokenBalanceBadge(
                balance: tokenBalance,
                onTap: () {
                  // Navigate to redeem/top-up screen
                  Navigator.pushNamed(
                      context, '/redeem'); // Make sure route exists
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
