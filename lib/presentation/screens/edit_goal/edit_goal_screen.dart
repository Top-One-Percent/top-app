import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/domain/models/goal.dart';
import 'package:top/presentation/screens/blocs/goal_bloc/goal_bloc.dart';
import 'package:top/presentation/widgets/widgets.dart';

class EditGoalScreen extends StatefulWidget {
  final int goalId;

  const EditGoalScreen({super.key, required this.goalId});

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  late TextEditingController _nameController;
  late TextEditingController _targetController;
  late Color _selectedColor;
  late TextEditingController _dateController;
  late ValueNotifier<DateTime?> dateNotifier;

  @override
  void initState() {
    super.initState();

    final Goal goal = context.read<GoalBloc>().state.goals[widget.goalId];

    _nameController = TextEditingController(text: goal.name);
    _targetController = TextEditingController(text: goal.target.toString());
    _dateController = TextEditingController(text: goal.targetDate.toString().substring(0, 10));
    _selectedColor = goal.color;
    dateNotifier = ValueNotifier<DateTime?>(goal.targetDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _dateController.dispose();
    dateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Goal: ${_nameController.text}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 35.0),
              TextFormFieldWidget(
                controller: _nameController,
                labelText: 'Goal Name',
                hintText: 'Ex: 100kg in bench press',
                icon: Icons.edit,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20.0),
              TextFormFieldWidget(
                controller: _targetController,
                labelText: 'Goal Target',
                hintText: 'Ex: 100 (just the number)',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              DateSelectorWidget(
                controller: _dateController,
                dateNotifier: dateNotifier,
                labelText: 'Goal Target Date',
                hintText: 'Goal Target Date',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 20.0),
              ColorPickerFormFieldWidget(
                selectedColor: _selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              WhiteFilledButtonWidget(
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _targetController.text.isEmpty ||
                      dateNotifier.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline),
                            SizedBox(width: 10.0),
                            Text(
                              'Please fill all fields',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  BlocProvider.of<GoalBloc>(context).add(
                    EditGoal(
                      widget.goalId,
                      _nameController.text,
                      int.parse(_targetController.text),
                      _selectedColor,
                      dateNotifier.value!,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_box_rounded,
                          ),
                          SizedBox(width: 10.0),
                          Text('Goal Edited Successfully!',
                              style: TextStyle(color: Colors.white, fontSize: 16.0)),
                        ],
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );

                  appRouter.pop();
                },
                buttonText: 'Edit Goal',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
