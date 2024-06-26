import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/widgets/widgets.dart';

class GoalProgressView extends StatelessWidget {
  final int goalId;

  const GoalProgressView({Key? key, required this.goalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, state) {
        final goal = state.goals[goalId];
        final lastLog = goal.logs.isNotEmpty ? goal.logs.last.currentValue : 0;
        final achievementPercentage = lastLog / goal.target;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: achievementPercentage,
                      strokeWidth: 5,
                      backgroundColor: AppColors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showUpdateValueDialog(context, goalId, lastLog);
                    },
                    child: Text(
                      '$lastLog',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularButton(
                    icon: Icons.remove,
                    onPressed: () {
                      if (lastLog - 1 >= 0) {
                        context.read<GoalBloc>().add(UpdateGoal(goalId, lastLog - 1));
                      }
                    },
                  ),
                  const SizedBox(width: 50.0),
                  CircularButton(
                    icon: Icons.add,
                    onPressed: () {
                      if (lastLog + 1 <= goal.target) {
                        context.read<GoalBloc>().add(UpdateGoal(goalId, lastLog + 1));
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateValueDialog(BuildContext context, int goalId, int currentValue) {
    final TextEditingController _valueController = TextEditingController(text: '$currentValue');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update value',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          content: TextFormFieldWidget(
            controller: _valueController,
            keyboardType: TextInputType.number,
            labelText: '',
            hintText: '',
            icon: Icons.edit,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            WhiteFilledButtonWidget(
              onPressed: () {
                final newValue = int.tryParse(_valueController.text);
                if (newValue != null) {
                  context.read<GoalBloc>().add(UpdateGoal(goalId, newValue));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a valid number')),
                  );
                }
              },
              buttonText: 'Ok',
            )
          ],
        );
      },
    );
  }
}
