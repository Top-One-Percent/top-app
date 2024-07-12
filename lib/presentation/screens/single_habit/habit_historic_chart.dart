import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/blocs/habits_bloc/habits_bloc.dart';

class HabitHistoricChart extends StatelessWidget {
  final Duration viewDuration;
  final int habitId;
  const HabitHistoricChart({super.key, required this.viewDuration, required this.habitId});

  @override
  Widget build(BuildContext context) {
    int daysCount = _getDaysCount(viewDuration);
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        final Habit habit = state.habits[habitId];

        final List<double> complianceRates = habit.dailyHabitLogs.isNotEmpty
            ? habit.dailyHabitLogs.map((e) => e.complianceRate / habit.target).toList()
            : [];

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: daysCount == 7 || daysCount == 20 ? 7 : 12,
            childAspectRatio: 1,
          ),
          itemCount: daysCount,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Color(habit.colorValue)
                    .withOpacity(index < complianceRates.length ? complianceRates[index] : 0),
                border: Border.all(color: Colors.grey[850]!),
              ),
            );
          },
        );
      },
    );
  }
}

int _getDaysCount(Duration duration) {
  //? Adjust the # of cells based on view duration
  if (duration == Duration(days: 7)) {
    return 7;
  } else if (duration == Duration(days: 30)) {
    return 30;
  } else {
    return 365;
  }
}
