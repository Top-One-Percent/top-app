import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/widgets/widgets.dart';

class EditDailyGoalPopup extends StatelessWidget {
  final String currentValue;
  final int goalId;
  final DevelopmentList? list;

  const EditDailyGoalPopup(
      {super.key, required this.currentValue, required this.goalId, this.list});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: const Text(
        'Edit Goal',
        style: TextStyle(color: Colors.white),
      ),
      content: TextFormFieldWidget(
        controller: controller,
        labelText: '',
        hintText: 'Enter a new name',
        icon: Icons.edit,
        keyboardType: TextInputType.name,
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
            if (controller.text.isNotEmpty) {
              if (list == null) {
                context.read<DailyGoalsBloc>().add(
                      EditDailyGoal(
                        dailyGoalId: goalId,
                        newName: controller.text,
                      ),
                    );
              } else {
                context.read<DevelopmentGoalsBloc>().add(
                      EditDevGoal(
                        list: list!,
                        devGoalId: goalId,
                        newName: controller.text,
                      ),
                    );
              }
              appRouter.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 700),
                  content: Text('Enter a valid name'),
                ),
              );
            }
          },
          buttonText: 'Save',
        )
      ],
    );
  }
}
