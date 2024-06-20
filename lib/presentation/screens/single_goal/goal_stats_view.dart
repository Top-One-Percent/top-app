import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/single_goal/flip_countdown.dart';
import 'package:top/presentation/screens/single_goal/goal_progress_chart.dart';

class GoalStatsView extends StatelessWidget {
  final int goalId;

  const GoalStatsView({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, state) {
        final goal = state.goals[goalId];
        return SingleChildScrollView(
          child: Column(
            children: [
              const Text('Progress', style: TextStyle(fontSize: 28.0)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 300,
                  child: GoalProgressChart(
                    goal: goal,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('Time Left', style: TextStyle(fontSize: 28.0)),
              const SizedBox(height: 20.0),
              FlipCountdown(targetDate: goal.targetDate)
            ],
          ),
        );
      },
    );
  }
}
