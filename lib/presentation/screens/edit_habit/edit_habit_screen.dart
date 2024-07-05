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

  bool hasDecimalPart(double number) {
    return number % 1 != 0;
  }

  @override
  void initState() {
    super.initState();

    final habit = context.read<HabitsBloc>().state.habits[widget.habitId];
    final goalBloc = context.read<GoalBloc>().state.goals;
    Goal linkedGoal = goalBloc.firstWhere(
      (goal) => goal.id == habit.linkedGoalId,
      orElse: () => Goal(
        name: '',
        target: 0,
        color: Colors.black,
        targetDate: DateTime.now(),
      ),
    );

    _nameController = TextEditingController(text: habit.name);
    _selectedUnitType = habit.unitType;

    double count = habit.target.toDouble();
    if (_selectedUnitType == 'hr') {
      count = count / 3600;
    } else if (_selectedUnitType == 'min') {
      count = count / 60;
    }

    _countController = TextEditingController(
        text: hasDecimalPart(count) ? count.toString() : count.toInt().toString());

    _selectedColor = Color(habit.colorValue);
    _selectedDays = habit.frequency;
    _selectedHours = habit.remidersTime ?? [];
    _selectedIcon = habit.icon;
    _selectedSteps = habit.steps ?? [];
    _selectedGoal = linkedGoal;
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
                  initialIcon: _selectedIcon,
                  onIconSelected: (icon) {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                UnitTypeSelectorWidget(
                  initialUnit: habit.unitType,
                  onUnitSelected: (unitType) {
                    setState(() {
                      _selectedUnitType = unitType;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                StepsCreatorWidget(
                  initialSteps: habit.steps,
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
                            Text('Habit Edited Successfully!',
                                style: TextStyle(color: Colors.white, fontSize: 16.0)),
                          ],
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    appRouter.pop();
                  },
                  buttonText: 'Edit Habit',
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
