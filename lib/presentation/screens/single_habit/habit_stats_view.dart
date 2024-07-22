import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top/presentation/screens/single_habit/habit_historic_chart.dart';

class HabitStatsView extends StatefulWidget {
  final int habitId;
  const HabitStatsView({super.key, required this.habitId});

  @override
  State<HabitStatsView> createState() => _HabitStatsViewState();
}

class _HabitStatsViewState extends State<HabitStatsView> {
  int weekNum = 0;

  String getWeekRange(DateTime dateNow) {
    final today = dateNow.weekday;
    final mondayDate = dateNow.subtract(Duration(days: today - 1));
    final sundayDate = mondayDate.add(Duration(days: 6));

    final mondayDateFormatted = DateFormat('dd MMM').format(mondayDate);
    final sundayDateFormatted = DateFormat('dd MMM').format(sundayDate);

    return '$mondayDateFormatted - $sundayDateFormatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  weekNum--;
                });
              },
              icon: const Icon(Icons.arrow_back_ios, size: 20.0),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  weekNum = 0;
                });
              },
              child: Text(
                weekNum == 0
                    ? 'This Week'
                    : getWeekRange(DateTime.now().subtract(Duration(days: 7 * weekNum))),
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            IconButton(
              onPressed: weekNum < 0
                  ? () {
                      setState(() {
                        weekNum++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward_ios, size: 20.0),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: HabitHistoricChart(habitId: widget.habitId, week: weekNum),
        ),
      ],
    ));
  }
}
