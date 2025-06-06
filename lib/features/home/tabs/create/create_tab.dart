import 'package:flutter/material.dart';

class CreateTab extends StatelessWidget {
  const CreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text(
            '🤖 Create Your Own Chatbot',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Upload data and generate a smart chatbot that can answer questions based on your content.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          _buildOptionCard(
            context,
            icon: Icons.picture_as_pdf,
            title: 'Upload PDF',
            onTap: () {
              // TODO: Implement PDF upload flow
            },
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            context,
            icon: Icons.text_fields,
            title: 'Paste Text',
            onTap: () {
              // TODO: Implement text input flow
            },
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            context,
            icon: Icons.link,
            title: 'Import from URL',
            onTap: () {
              // TODO: Implement link-based bot creation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
