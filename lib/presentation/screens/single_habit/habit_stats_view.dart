import 'package:flutter/material.dart';
import 'package:top/presentation/screens/single_habit/habit_historic_chart.dart';

class HabitStatsView extends StatelessWidget {
  final int habitId;
  const HabitStatsView({super.key, required this.habitId});

  Widget buildHabitChart(String title, int days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22.0),
        ),
        SizedBox(
          height: days != 365 ? 150 : 1100,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: HabitHistoricChart(viewDuration: Duration(days: days), habitId: habitId),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      children: [
        buildHabitChart('This Week', 7),
        buildHabitChart('This Month', 30),
        buildHabitChart('This Year', 365),
      ],
    ));
  }
}
