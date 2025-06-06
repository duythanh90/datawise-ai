import 'package:flutter/material.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedBots = [
      {
        'name': 'Legal Advisor',
        'description': 'Helps you understand legal documents.'
      },
      {
        'name': 'FinanceBot',
        'description': 'Answers questions about budgeting and investment.'
      },
      {
        'name': 'Health AI',
        'description':
            'Provides general health information from uploaded files.'
      },
      {
        'name': 'Job Prep Coach',
        'description': 'Prepares you for tech interviews.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🧠 Explore Shared Chatbots',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search bots...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: sharedBots.length,
              itemBuilder: (context, index) {
                final bot = sharedBots[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child:
                          Icon(Icons.chat_bubble_outline, color: Colors.white),
                    ),
                    title: Text(bot['name'] ?? ''),
                    subtitle: Text(bot['description'] ?? ''),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Open shared chatbot view
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
