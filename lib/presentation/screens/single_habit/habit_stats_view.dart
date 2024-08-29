import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top/presentation/screens/single_habit/habit_historic_chart.dart';
import 'package:top/presentation/widgets/widgets.dart';

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
    final sundayDate = mondayDate.add(const Duration(days: 6));

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
                      : getWeekRange(DateTime.now()
                          .subtract(Duration(days: 7 * weekNum * -1))),
                  style: const TextStyle(fontSize: 22.0),
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
          const SizedBox(height: 20.0),
          const Text('Your Stats', style: TextStyle(fontSize: 24.0)),
          const SizedBox(height: 20.0),
          _buildStatsGrid(),
        ],
      ),
    );
  }
}

Widget _buildStatsGrid() {
  return Flexible(
    child: GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 18.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      children: const [
        StatsCardWidget(
          icon: Icons.local_fire_department_outlined,
          name: 'Best Streak',
          data: '7 days',
        ),
        StatsCardWidget(
          icon: Icons.verified_outlined,
          name: 'Total Done',
          data: '31 days',
        ),
        StatsCardWidget(
          icon: Icons.bar_chart_outlined,
          name: 'Daily Avg',
          data: '82.31%',
        ),
        StatsCardWidget(
          icon: Icons.pie_chart,
          name: 'Overall Rate',
          data: '21.24%',
        ),
      ],
    ),
  );
}
