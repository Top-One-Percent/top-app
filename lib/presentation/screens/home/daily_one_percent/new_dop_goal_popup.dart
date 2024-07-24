import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/widgets/widgets.dart';

class NewDopGoalPopup extends StatelessWidget {
  final DevelopmentList? list;

  const NewDopGoalPopup({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: const Text(
        'Add Goal',
        style: TextStyle(color: Colors.white),
      ),
      content: TextFormFieldWidget(
        controller: _controller,
        labelText: 'New Goal Name',
        hintText: 'Enter the goal name',
        icon: Icons.add,
        keyboardType: TextInputType.text,
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
            if (_controller.text.isNotEmpty) {
              if (list == null) {
                context.read<DailyGoalsBloc>().add(AddDailyGoal(dailyGoalName: _controller.text));
              } else {
                context
                    .read<DevelopmentGoalsBloc>()
                    .add(AddDevGoal(list: list!, devGoalName: _controller.text));
              }
              appRouter.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enter a valid name')),
              );
            }
          },
          buttonText: 'Add',
        )
      ],
    );
  }
}
