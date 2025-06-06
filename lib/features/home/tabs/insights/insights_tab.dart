import 'package:flutter/material.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Insights',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Get AI tips and track how your chatbots are performing.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const Text(
            '🤖 AI Tips',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('- Keep your data clean and focused for better answers.'),
          const Text('- Use short questions to get fast, accurate replies.'),
          const Text('- Train bots with updated documents regularly.'),
          const SizedBox(height: 24),
          const Text(
            '📈 Usage Stats (Last 7 Days)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildStatRow('Total Questions Asked:', '124'),
          _buildStatRow('Most Active Bot:', 'FinanceBot'),
          _buildStatRow('Avg. Response Time:', '1.3s'),
          const SizedBox(height: 24),
          const Placeholder(
            fallbackHeight: 180,
            strokeWidth: 1.5,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Insights chart coming soon...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
