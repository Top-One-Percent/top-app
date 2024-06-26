import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/widgets/widgets.dart';

class NewHabitScreen extends StatefulWidget {
  const NewHabitScreen({super.key});

  @override
  State<NewHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _countController = TextEditingController();

    Color _selectedColor = AppColors.colorOptions[0];
    List<int> _selectedDays = [];
    List<TimeOfDay> _selectedHours = [];
    String _selectedIcon = '';
    String _selectedUnitType = '';

    void _updateSelectedHours(List<TimeOfDay> hours) {
      setState(() {
        _selectedHours = hours;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
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
                DaysSelectorWidget(
                  onSelectionChanged: (selectedDays) {
                    setState(() {
                      _selectedDays = selectedDays;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                HoursSelectorWidget(onHoursChanged: _updateSelectedHours),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
