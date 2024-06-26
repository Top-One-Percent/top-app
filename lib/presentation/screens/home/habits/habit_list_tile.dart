import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';

class HabitListTile extends StatelessWidget {
  final int habitIndex;
  const HabitListTile({super.key, required this.habitIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        var habit = state.habits[habitIndex];

        return ListTile(
          title: Text(habit.name, style: const TextStyle(color: Colors.white, fontSize: 20.0)),
          trailing: Text(
            '${(_calculateProgress(habit) * 100).round().toString()}%',
            style: const TextStyle(fontSize: 18.0),
          ),
          onTap: () {
            appRouter.push('/habit/$habitIndex');
          },
        );
      },
    );
  }

  double _calculateProgress(Habit habit) {
    if (habit.habitLogs.isEmpty) return 0.0;
    final latestLog = habit.habitLogs.last;
    return latestLog.complianceRate / habit.target;
  }
}
