import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/goal.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final goalIndex =
        context.read<GoalBloc>().state.goals.indexWhere((g) => g.id == goal.id);
    return ListTile(
      title: Text(goal.name,
          style: const TextStyle(color: Colors.white, fontSize: 18.0)),
      trailing: Text(
        '${(_calculateProgress(goal) * 100).round().toString()}%',
        style: const TextStyle(fontSize: 18.0),
      ),
      subtitle: LinearProgressIndicator(
        value: _calculateProgress(goal),
        backgroundColor: goal.color.withOpacity(0.3),
        valueColor: AlwaysStoppedAnimation(goal.color),
      ),
      onTap: () {
        appRouter.push('/goal/$goalIndex');
      },
    );
  }

  double _calculateProgress(Goal goal) {
    if (goal.logs.isEmpty) return 0.0;
    final latestLog = goal.logs.last;
    return latestLog.currentValue / goal.target;
  }
}
