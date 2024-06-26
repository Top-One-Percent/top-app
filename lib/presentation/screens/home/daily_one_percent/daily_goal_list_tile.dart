import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/domain/models/models.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/daily_one_percent/edit_daily_goal_popup.dart';

class DailyGoalListTile extends StatelessWidget {
  final int goalId;
  final DailyGoal goal;

  const DailyGoalListTile({super.key, required this.goal, required this.goalId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyGoalsBloc, DailyGoalsState>(
      builder: (context, state) {
        var currentGoal = state.dailyGoals[goalId];
        bool isCompleted = currentGoal.isCompleted;

        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => EditDailyGoalPopup(
                        currentValue: currentGoal.name,
                        goalId: goalId,
                      ));
            },
            child: Text(
              currentGoal.name,
              style: TextStyle(
                fontSize: 18.0,
                decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                decorationThickness: 3,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.read<DailyGoalsBloc>().add(ToggleDailyGoalStatus(goalId: goalId));
            },
            icon: Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined, size: 30),
          ),
        );
      },
    );
  }
}
