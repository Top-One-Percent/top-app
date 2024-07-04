import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/config/theme/app_colors.dart';

import '../../../domain/models/models.dart';
import '../../widgets/widgets.dart';
import '../blocs/blocs.dart';

class EditHabitScreen extends StatefulWidget {
  final int habitId;
  EditHabitScreen({super.key, required this.habitId});

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  late TextEditingController _nameController;

  late TextEditingController _countController;

  late Color _selectedColor = AppColors.colorOptions[0];

  late List<int> _selectedDays = [];

  late List<String> _selectedHours = [];

  late String _selectedIcon = '57402';

  late String _selectedUnitType = 'rep';

  late List<String> _selectedSteps = [];

  late var count;

  late Goal? _selectedGoal;

  @override
  void initState() {
    final habit = context.read<HabitsBloc>().state.habits[widget.habitId];
    final Goal linkedGoal = context
            .read<GoalBloc>()
            .state
            .goals
            .where((goal) => goal.id == habit.linkedGoalId)
            .isNotEmpty
        ? context.read<GoalBloc>().state.goals.where((goal) => goal.id == habit.linkedGoalId).first
        : Goal(
            name: '',
            target: 0,
            color: Colors.black,
            targetDate: DateTime.now(),
          );

    _nameController = TextEditingController(text: habit.name);
    _countController = TextEditingController(text: habit.target.toString());
    _selectedColor = Color(habit.colorValue);
    _selectedDays = habit.frequency;
    _selectedHours = habit.remidersTime ?? [];
    _selectedIcon = habit.icon;
    _selectedUnitType = habit.unitType;
    _selectedSteps = habit.steps ?? [];
    count = _countController.text;
    _selectedGoal = linkedGoal;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habit = context.read<HabitsBloc>().state.habits[widget.habitId];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Habit: ${habit.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 35.0),
                TextFormFieldWidget(
                  controller: _nameController,
                  labelText: 'Habit Name',
                  hintText: 'Ex: Do 100 push-ups',
                  icon: Icons.edit,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20.0),
                TextFormFieldWidget(
                  controller: _countController,
                  labelText: 'Habit Count',
                  hintText: 'Ex: 100 (for 100 push-ups)',
                  icon: Icons.numbers,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20.0),
                ColorPickerFormFieldWidget(
                  selectedColor: _selectedColor,
                  onColorChanged: (color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                RelatedGoalSelector(
                  selectedGoal: _selectedGoal,
                  onGoalChanged: (selGoal) {
                    setState(() {
                      _selectedGoal = selGoal;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                DaysSelectorWidget(
                  initialSelectedDays: _selectedDays,
                  onSelectionChanged: (selectedDays) {
                    setState(() {
                      _selectedDays = selectedDays;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                HoursSelectorWidget(
                  onHoursChanged: (hours) {
                    setState(() {
                      _selectedHours = hours.map((e) => e.format(context)).toList();
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                IconSelectorWidget(
                  onIconSelected: (icon) {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                UnitTypeSelectorWidget(onUnitSelected: (unitType) {
                  setState(() {
                    _selectedUnitType = unitType;
                  });
                }),
                const SizedBox(height: 20.0),
                StepsCreatorWidget(
                  onStepsChanged: (steps) {
                    setState(() {
                      _selectedSteps = steps;
                    });
                  },
                ),
                const SizedBox(height: 25.0),
                WhiteFilledButtonWidget(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _countController.text.isEmpty ||
                        _selectedDays.isEmpty) {
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

                    if (_selectedUnitType != 'rep') {
                      if (_selectedUnitType == 'hr') {
                        count = (int.parse(_countController.text) * 3600).toDouble();
                      } else if (_selectedUnitType == 'min') {
                        count = (int.parse(_countController.text) * 60).toDouble();
                      }
                    } else {
                      count = double.parse(_countController.text);
                    }

                    context.read<HabitsBloc>().add(
                          EditHabit(
                            habitId: habit.id,
                            name: _nameController.text,
                            frequency: _selectedDays,
                            color: _selectedColor,
                            icon: _selectedIcon,
                            unitType: _selectedUnitType,
                            target: count,
                            steps: _selectedSteps,
                            remindersTime: _selectedHours,
                            linkedGoalId: _selectedGoal != null ? _selectedGoal!.id : '0',
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
                            Text('Habit Added Successfully!',
                                style: TextStyle(color: Colors.white, fontSize: 16.0)),
                          ],
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    appRouter.pop();
                  },
                  buttonText: 'Create Habit',
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
