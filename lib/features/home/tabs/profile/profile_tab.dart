import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = 'John Doe';
    final userEmail = 'john.doe@example.com';

    return Container(
      color: const Color(0xFF121212), // Dark background to match nav bar
      child: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  userName[0],
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                userEmail,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[400]),
              ),
              const SizedBox(height: 32),
              Card(
                color: Colors.grey[900],
                child: ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.white54),
                  onTap: () {
                    // TODO: Navigate to settings screen
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.grey[900],
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // TODO: Add logout logic
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
