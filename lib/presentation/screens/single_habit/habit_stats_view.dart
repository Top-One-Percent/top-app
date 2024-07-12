import 'package:flutter/material.dart';
import 'package:top/presentation/screens/single_habit/habit_historic_chart.dart';

class HabitStatsView extends StatelessWidget {
  final int habitId;
  const HabitStatsView({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: HabitHistoricChart(viewDuration: Duration(days: 7), habitId: habitId)),
        ],
      ),
    );
  }
}
