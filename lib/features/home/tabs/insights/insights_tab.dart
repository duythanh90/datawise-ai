import 'package:flutter/material.dart';
import 'package:datawiseai/features/home/tabs/insights/widgets/ai_tips_section.dart';
import 'package:datawiseai/features/home/tabs/insights/widgets/insight_stat_row.dart';
import 'package:datawiseai/features/home/tabs/insights/widgets/insights_line_chart.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AiTipsSection(),
          const SizedBox(height: 24),
          const Text(
            'Usage Stats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const InsightStatRow(label: 'Total Questions Asked:', value: '124'),
          const InsightStatRow(label: 'Most Active Bot:', value: 'FinanceBot'),
          const InsightStatRow(label: 'Avg. Response Time:', value: '1.3s'),
          const SizedBox(height: 24),
          const InsightsLineChart(),
        ],
      ),
    );
  }
}
