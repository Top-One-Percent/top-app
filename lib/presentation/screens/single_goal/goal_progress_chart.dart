import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:top/domain/models/goal.dart';

class GoalProgressChart extends StatelessWidget {
  final Goal goal;

  const GoalProgressChart({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      goal.color,
      goal.color,
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: goal.target > 10 ? goal.target / 10 : goal.target / goal.target,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: goal.target > 10 ? goal.target / 10 : goal.target / goal.target,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  );
                  return Text(value.toInt().toString(), style: style);
                },
                reservedSize: 40,
              ),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: goal.logs.length.toDouble() - 1,
          minY: 0,
          maxY: goal.target.toDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: goal.logs
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.currentValue.toDouble()))
                  .toList(),
              isCurved: false,
              color: goal.color,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors.map((color) => color.withOpacity(0.4)).toList(),
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
