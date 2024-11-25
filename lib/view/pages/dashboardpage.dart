import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizapp/components/common_button.dart';

class DashBoardPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const DashBoardPage(
      {super.key, required this.totalQuestions, required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Performance Summary',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: totalQuestions.toDouble(),
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: correctAnswers.toDouble(),
                          color: Colors.green,
                          width: 20,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: (totalQuestions - correctAnswers).toDouble(),
                          color: Colors.red,
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value == 1
                                ? 'Correct           '
                                : '              Incorrect',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple[500],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommonButton(
                color: Colors.purple[500],
                text: 'Back',
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
