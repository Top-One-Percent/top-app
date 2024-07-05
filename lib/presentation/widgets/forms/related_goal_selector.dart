import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/domain/models/models.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';

class RelatedGoalSelector extends StatelessWidget {
  final Goal? selectedGoal;
  final ValueChanged<Goal?> onGoalChanged;

  const RelatedGoalSelector({super.key, required this.selectedGoal, required this.onGoalChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(builder: (context, state) {
      final goals = state.goals;
      final items = <DropdownMenuItem<Goal?>>[
        const DropdownMenuItem<Goal?>(
          value: null, // This represents the 'None' option
          child: Text('None'),
        ),
      ];

      items.addAll(
        goals
            .map(
              (goal) => DropdownMenuItem<Goal?>(
                value: goal,
                child: Text(goal.name),
              ),
            )
            .toList(),
      );

      return DropdownButtonFormField<Goal?>(
        value: selectedGoal?.name != '' ? selectedGoal : null,
        hint: const Text('Select Related Goal'),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
        items: items,
        onChanged: onGoalChanged,
      );
    });
  }
}
