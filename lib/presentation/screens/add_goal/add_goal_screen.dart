import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/screens/blocs/goal_bloc/goal_bloc.dart';
import 'package:top/presentation/widgets/widgets.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  Color _selectedColor = AppColors.colorOptions[0];
  final TextEditingController _dateController = TextEditingController();
  final ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 35.0),
              TextFormFieldWidget(
                controller: _nameController,
                labelText: 'Goal Name',
                hintText: 'Ex: 100kg in bench press',
                icon: Icons.edit,
                keyboardType: TextInputType.text,
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
                        duration: Duration(milliseconds: 700),
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
                    AddGoal(
                      _nameController.text,
                      int.parse(_targetController.text),
                      _selectedColor,
                      dateNotifier.value!,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 700),
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_box_rounded,
                          ),
                          SizedBox(width: 10.0),
                          Text('Goal Added Successfully!',
                              style: TextStyle(color: Colors.white, fontSize: 16.0)),
                        ],
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );

                  appRouter.pop();
                },
                buttonText: 'Add Goal',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
