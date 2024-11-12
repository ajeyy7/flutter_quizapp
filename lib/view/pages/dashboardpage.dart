import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceDashboardScreen extends StatelessWidget {
  final int totalQuestions;
  final int answeredCount;
  final int unansweredCount;

  const PerformanceDashboardScreen({
    Key? key,
    required this.totalQuestions,
    required this.answeredCount,
    required this.unansweredCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prevent issues if totalQuestions is 0
    final validTotalQuestions = totalQuestions > 0 ? totalQuestions : 1;  // Ensure no zero value
    final validAnsweredCount = answeredCount >= 0 ? answeredCount : 0; // Ensure non-negative values
    final validUnansweredCount = unansweredCount >= 0 ? unansweredCount : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Performance Summary
            Text(
              'Total Questions: $validTotalQuestions',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Answered: $validAnsweredCount',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            Text(
              'Unanswered: $validUnansweredCount',
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 20),

            // Bar chart visualization
            const Text(
              'Performance Visualization',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildBarChart(validTotalQuestions, validAnsweredCount, validUnansweredCount),
            const SizedBox(height: 20),

            // Restart Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dashboard screen
              },
              child: const Text('Go Back to Quiz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bar Chart to show Answered vs Unanswered
  Widget _buildBarChart(int totalQuestions, int answeredCount, int unansweredCount) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: totalQuestions > 0 ? totalQuestions.toDouble() : 1.0,  // Prevent NaN or zero maxY
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: answeredCount.toDouble(),
                color: Colors.green,
                width: 25,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: unansweredCount.toDouble(),
                color: Colors.red,
                width: 25,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
        ],
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }
}
