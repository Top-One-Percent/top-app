import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/domain/models/models.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/daily_one_percent/edit_daily_goal_popup.dart';

class DevGoalListTile extends StatelessWidget {
  final DevelopmentList list;
  final int goalId;
  final DevelopmentGoal goal;

  const DevGoalListTile({super.key, required this.goal, required this.goalId, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevelopmentGoalsBloc, DevelopmentGoalsState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => EditDailyGoalPopup(
                  currentValue: goal.name,
                  goalId: goalId,
                  list: list,
                ),
              );
            },
            child: Text(
              goal.name,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          leading: list == DevelopmentList.toImprove
              ? IconButton(
                  onPressed: () {
                    context.read<DevelopmentGoalsBloc>().add(ToggleDevGoalList(
                        currentList: DevelopmentList.toImprove, currentListId: goalId));
                  },
                  icon: const Icon(
                    Icons.call_made_sharp,
                    color: Colors.red,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    context.read<DevelopmentGoalsBloc>().add(ToggleDevGoalList(
                        currentList: DevelopmentList.toKeep, currentListId: goalId));
                  },
                  icon: const Icon(
                    Icons.anchor_sharp,
                    color: Colors.green,
                  ),
                ),
        );
      },
    );
  }
}
