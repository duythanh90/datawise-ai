import 'package:flutter/material.dart';

class UsageStatsSection extends StatelessWidget {
  const UsageStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usage Stats (Last 7 Days)',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        _StatRow(label: 'Total Questions Asked:', value: '124'),
        _StatRow(label: 'Most Active Bot:', value: 'FinanceBot'),
        _StatRow(label: 'Avg. Response Time:', value: '1.3s'),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(label, style: const TextStyle(color: Colors.white70))),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
